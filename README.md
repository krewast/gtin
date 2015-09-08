# gtin

A set of libraries for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes.

It also serves as an example for implementing a library in multiple languages with linting and style checking, unit tests, code coverage and publishing to public binary repositories using Gradle as a common build system.

* [gtin.java](gtin.java/README.md)
* [gtin.js](gtin.js/README.md)
* [gtin.rb](gtin.rb/README.md)

[![Build Status](https://travis-ci.org/powa/gtin.svg?branch=master)](https://travis-ci.org/powa/gtin) [![Coverage Status](https://coveralls.io/repos/powa/gtin/badge.svg?branch=master&service=github)](https://coveralls.io/github/powa/gtin?branch=master)

## Getting Started

Install the development dependencies for all modules

    ./gradlew init

Note: all of the commands listed here can also be executed in one of the module directories to run the command for just that module, e.g.

    cd gtin.js
    ../gradlew init

## Building

To build all modules and run all unit tests run

    ./gradlew clean build

## Coverage

To generate coverage reports for all modules and send to [coveralls.io](https://coveralls.io)

   ./gradlew coverage

## Publishing

To publish all modules to their respective binary repositories

    ./gradlew publish
