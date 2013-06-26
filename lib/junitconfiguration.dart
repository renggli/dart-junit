// Copyright (c) 2013, Lukas Renggli <renggli@gmail.com>

library junitconfiguration;

import 'dart:io';
import 'package:meta/meta.dart';
import 'package:unittest/unittest.dart';

/**
 * A test configuration that emits JUnit compatible XML output.
 */
class JUnitConfiguration extends Configuration {

  /**
   * Install this configuration with the testing framework.
   */
  static void install({StringSink output, DateTime time, String hostname}) {
    unittestConfiguration = new JUnitConfiguration(
        output: output,
        time: time,
        hostname: hostname);
  }

  /**
   * Creates a new configuration instance with an optional output sink.
   */
  factory JUnitConfiguration({StringSink output, DateTime time, String hostname}) {
    return new JUnitConfiguration._internal(
        output != null ? output : stdout,
        time != null ? time : new DateTime.now(),
        hostname != null ? hostname : Platform.localHostname);
  }

  final StringSink _output;
  final DateTime _time;
  final String _hostname;

  JUnitConfiguration._internal(this._output, this._time, this._hostname);

  String get name => 'JUnit Test Configuration';

  @override
  void onInit() {
    // nothing to be done
  }

  @override
  void onSummary(int passed, int failed, int errors, List<TestCase> results, String uncaughtError) {
    var totalTime = 0, skipped = 0;
    for (var testcase in results) {
      if (testcase.runningTime != null) {
        totalTime += testcase.runningTime.inMilliseconds;
      }
      if (!testcase.enabled) {
        skipped++;
      }
    }
    _output.writeln('<?xml version="1.0" encoding="UTF-8" ?>');
    _output.writeln('<testsuite name="All tests" hostname="${_xml(this._hostname)}" tests="${results.length}" failures="$failed" errors="$errors" skipped="$skipped" time="${totalTime / 1000.0}" timestamp="${_time}">');
    for (TestCase testcase in results) {
      var time = testcase.runningTime != null ? testcase.runningTime.inMilliseconds : 0;
      var name = testcase.description;
      if (testcase.currentGroup != null && testcase.currentGroup != '') {
        name = '${testcase.currentGroup} ${name}';
      }
      _output.writeln('  <testcase id="${testcase.id}" name="${_xml(name)}" time="${time / 1000.0}">');
      if (testcase.result == FAIL) {
        _output.writeln('    <failure>${_xml(testcase.message)}</failure>');
      } else if (testcase.result == ERROR) {
        _output.writeln('    <error>${_xml(testcase.message)}</error>');
      } else if (!testcase.enabled) {
        _output.writeln('    <skipped>${_xml(testcase.message)}</skipped>');
      }
      if (testcase.stackTrace != null && testcase.stackTrace != '') {
        _output.writeln('    <system-err>${_xml(testcase.stackTrace)}</system-err>');
      }
      _output.writeln('  </testcase>');
    }
    if (uncaughtError != null && uncaughtError != '') {
      _output.writeln('  <system-err>${_xml(uncaughtError)}</system-err>');
    }
    _output.writeln('</testsuite>');
  }

  @override
  void onDone(bool success) {
    // nothing to be done
  }

  String _xml(value, [isNull = '']) {
    if (value == null) {
      value = isNull;
   }
    return value.toString()
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;');
  }

}