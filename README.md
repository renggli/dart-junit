JUnit Configuration
===================

[![Pub Package](https://img.shields.io/pub/v/junitconfiguration.svg)](https://pub.dartlang.org/packages/junitconfiguration)
[![GitHub Issues](https://img.shields.io/github/issues/renggli/dart-junit.svg)](https://github.com/renggli/dart-junit/issues)
[![GitHub Forks](https://img.shields.io/github/forks/renggli/dart-junit.svg)](https://github.com/renggli/dart-junit/network)
[![GitHub Stars](https://img.shields.io/github/stars/renggli/dart-junit.svg)](https://github.com/renggli/dart-junit/stargazers)
[![GitHub License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/renggli/dart-junit/master/LICENSE)

**Warning:** This library does not currently work with recent versions of the Dart testing framework. Due to the changed internal APIs it is not (easily) possible to make it work again. For now, if you want to use this library, write your tests using `unittesting 0.11.0` instead.

A test configuration producing JUnit compatible output. This is useful for continuous integration servers (such as Jenkins) that support displaying JUnit test results.

This library is open source, stable and well tested. Development happens on [GitHub](https://github.com/renggli/dart-junit). Feel free to report issues or create a pull-request there. The most recent stable versions are available through [pub.dartlang.org](http://pub.dartlang.org/packages/junitconfiguration).

Continuous build results are available from [Jenkins](http://jenkins.lukas-renggli.ch/job/dart-junit).


Installation and Use
--------------------

Add the dependency to your package's pubspec.yaml file:

    dependencies:
      junitconfiguration: ">=1.0.0 <2.0.0"

Then on the command line run:

    $ pub get

To import the package into your Dart tests add:

    import 'package:junitconfiguration/junitconfiguration.dart';

At the top of your main method, before the actual tests write:

    JUnitConfiguration.install();

And this is all that is needed.


Misc
----

### License

The MIT License, see [LICENSE](https://github.com/renggli/dart-junit/raw/master/LICENSE).
