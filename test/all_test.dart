library all_test;

import 'package:unittest/unittest.dart';
import 'package:junitconfiguration/junitconfiguration.dart';

void main() {
  test('empty test', () {
    var output = new StringBuffer();
    var time = new DateTime.now();
    var hostname = 'asterix';
    var config = new JUnitConfiguration(output: output, time: time, hostname: hostname);
    config.onInit();
    config.onStart();
    config.onSummary(1, 2, 3, [], null);
    config.onDone(true);
    expect(output.toString(), '<?xml version="1.0" encoding="UTF-8" ?>\n' +
        '<testsuite name="All tests" hostname="asterix" tests="0" failures="2" errors="3" skipped="0" time="0.0" timestamp="$time">\n'
        + '</testsuite>\n');
  });
  test('single test', () {
    var output = new StringBuffer();
    var time = new DateTime.now();
    var hostname = 'asterix';
    var config = new JUnitConfiguration(output: output, time: time, hostname: hostname);
    config.onInit();
    config.onStart();
    config.onSummary(1, 0, 0, [currentTestCase], null);
    config.onDone(true);
    expect(output.toString(), '<?xml version="1.0" encoding="UTF-8" ?>\n' +
        '<testsuite name="All tests" hostname="asterix" tests="1" failures="0" errors="0" skipped="0" time="0.0" timestamp="$time">\n'
        + '  <testcase id="2" name="single test" time="0.0">\n' + '  </testcase>\n' + '</testsuite>\n');
  });
  test('uncaught test', () {
    var output = new StringBuffer();
    var time = new DateTime.now();
    var hostname = 'asterix';
    var config = new JUnitConfiguration(output: output, time: time, hostname: hostname);
    config.onInit();
    config.onStart();
    config.onSummary(1, 2, 3, [], 'uncaught failure');
    config.onDone(true);
    expect(output.toString(), '<?xml version="1.0" encoding="UTF-8" ?>\n' +
        '<testsuite name="All tests" hostname="asterix" tests="0" failures="2" errors="3" skipped="0" time="0.0" timestamp="$time">\n'
        + '  <system-err>uncaught failure</system-err>\n' + '</testsuite>\n');
  });
}
