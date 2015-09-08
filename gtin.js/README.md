# gtin.js

A JavaScript library for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes.

[![Download](http://npmjs.com/package/gtin.js)](http://badge.fury.io/js/gtin.js)

## Using

Check if a string is a valid GTIN by validating the checksum

    Gtin.isValid("734092309436");   // true
    Gtin.isValid("734092309432");   // false
    Gtin.isValid12("734092309436"); // true
    Gtin.isValid13("734092309436"); // false

See if a string matches the general GTIN format

    Gtin.matchesFormat("00000000");   // true
    Gtin.matchesFormat12("00000000"); // false
    Gtin.matchesFormat("123");        // false
    Gtin.matchesFormat("aaaaaaaa");   // false

Calculate the check digit for a partial GTIN string

    Gtin.calculateCheckDigit("73409230943"); // 6

Create a GTIN string from a partial string

    Gtin.withCheckDigit("73409230943"); // 734092309436

Parse a string to a GTIN object

    Gtin gtin = Gtin.create("734092309436");

Convert a GTIN object back to a string

    gtin.toString();

Add gtin.js as a dependency of your application

As a regular script

    <script src="gtin.js"></script>

With [requirejs](http://requirejs.org) or other CommonJS loader

    <script data-main="scripts/main" src="scripts/require.js"></script>
    <script>
    requirejs(["gtin"], function(gtin) {
        // This function is called when scripts/require.js is loaded.
        var Gtin = gtin.Gtin;
        var GtinFormat = gtin.GtinFormat;
        var GtinFormatError = gtin.GtinFormatError;
    });
    <script>

Install with npm

    npm install gtin.js

And include as a node.js module

    var gtin = require("gtin.js");
    var Gtin = gtin.Gtin;
    var GtinFormat = gtin.GtinFormat;
    var GtinFormatError = gtin.GtinFormatError;

## Getting Started

Install the development dependencies

    ../gradlew init

Or directly with npm

    npm install

## Building

To build the library and run all unit tests use

    ../gradlew clean build

Alternatively run grunt directly with

    grunt

To view coverage report for a test suite open one of the test html files, e.g.

    src/test/html/gtin_test.html

## Coverage

Generate code coverage and send to [coveralls.io](https://coveralls.io)

    ../gradlew coverage

Or with grunt

    grunt coverage

## Publishing

The gtin.js library is published to [npm](https://www.npmjs.com).

Make sure you have [created an npm account](https://docs.npmjs.com/misc/developers) and logged into it

    npm login

With this configuration in place a deployment can be started with

    ../gradlew publish

Or directly with npm

    npm publish

You then need to manually log into [Bintray](https://bintray.com/powa/maven/gtin/view) and publish the archives to make them publicly available.

It is recommended you go to the 'Files' section of the latest version and add the `gtin-x.y.z.jar` to the download list using the 'Actions' menu.
