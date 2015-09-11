# gtin.obj

An Objective-C framework for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes.

[![Download](https://badge.fury.io/co/gtin.objc.svg)](https://cocoapods.org/pods/gtin.objc)

## Using

Check if a string is a valid GTIN by validating the checksum

    [GTIN isValidString:@"734092309436"];   // true
    [GTIN isValidString:@"734092309432"];   // false
    [GTIN isValidString12:@"734092309436"]; // true
    [GTIN isValidString13:@"734092309436"]; // false

See if a string matches the general GTIN format

    [GTIN stringMatchesFormat:@"00000000"];   // true
    [GTIN stringMatchesFormat12:@"00000000"]; // false
    [GTIN stringMatchesFormat:@"123"];        // false
    [GTIN stringMatchesFormat:@"aaaaaaaa"];   // false

Calculate the check digit for a partial GTIN string

    [GTIN calculateCheckDigitWithGTINWithoutCheckDigit:@"73409230943"]; // 6

Create a GTIN string from a partial string

    [GTIN stringWithCheckDigitWithGTINWithoutCheckDigit:@"73409230943"]; // 734092309436

Parse a string to a GTIN object

    GTIN *gtin = [GTIN gtin:@"734092309436"];

Convert a GTIN object back to a string

    gtin.description;

Add gtin.objc as a dependency of your application by adding the following line to your Podfile

    pod 'gtin.objc', '~> 1.1.1'

Then run

    pod install

## Getting Started

Install the development dependencies

    ../gradlew init

## Building

To build the library and run all unit tests use

    ../gradlew clean build

Alternatively import the project into Xcode to build.

To view a coverage report for the test suite run

    ./test.sh

## Coverage

Generate code coverage and send to [coveralls.io](https://coveralls.io)

    ../gradlew coverage

## Publishing

The gtin.objc library is published to [CocoaPods](https://cocoapods.org).

Make sure you have [registered a trunk account](https://guides.cocoapods.org/making/getting-setup-with-trunk.html).

With this configuration in place a deployment can be started with

    ../gradlew publish

Or directly with CocoaPods

    pod trunk push
