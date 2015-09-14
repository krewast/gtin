# gtin.php

A PHP library for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes.

[![Download](https://poser.pugx.org/powa/gtin/v/stable)](https://packagist.org/packages/powa/gtin)

## Using

Check if a string is a valid GTIN by validating the checksum

    use Powa\Gtin\Gtin;

    Gtin::isValid("734092309436");   // true
    Gtin::isValid("734092309432");   // false
    Gtin::isValid12("734092309436"); // true
    Gtin::isValid13("734092309436"); // false

See if a string matches the general GTIN format

    Gtin::matchesFormat("00000000");   // true
    Gtin::matchesFormat12("00000000"); // false
    Gtin::matchesFormat("123");        // false
    Gtin::matchesFormat("aaaaaaaa");   // false

Calculate the check digit for a partial GTIN string

    Gtin::calculateCheckDigit("73409230943"); // 6

Create a GTIN string from a partial string

    Gtin::withCheckDigit("73409230943"); // 734092309436

Parse a string to a GTIN object

    Gtin $gtin = Gtin::create("734092309436");

Convert a GTIN object back to a string

    (string) $gtin;

Add gtin.php as a dependency of your application with [Composer](https://getcomposer.org)

    "require": {
        "gtin.php": ">=1.1.1"
    },

## Getting Started

Install the development dependencies (currently none)

    ../gradlew init

Or directly with composer

    php ../composer.phar

## Building

To build the library and run all unit tests use

    ../gradlew clean build

Using composer directly

    php ../composer.phar test

## Coverage

Generate coverage and send to [coveralls.io](https://coveralls.io)

   ../gradlew coverage

Or

    php ../composer.phar test

## Publishing

The gtin.php library is published through [Packagist](https://packagist.org).
It indexes the public Git repository and has a hook to detect new pushes.
