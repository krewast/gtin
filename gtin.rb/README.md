# gtin.rb

A Ruby library for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes.

## Using

Check if a string is a valid GTIN by validating the checksum

    Gtin::Gtin.valid?("734092309436")   // true
    Gtin::Gtin.valid?("734092309432")   // false
    Gtin::Gtin.valid12?("734092309436") // true
    Gtin::Gtin.valid13?("734092309436") // false

See if a string matches the general GTIN format

    Gtin::Gtin.matches_format?("00000000")   // true
    Gtin::Gtin.matches_format12?("00000000") // false
    Gtin::Gtin.matches_format?("123")        // false
    Gtin::Gtin.matches_format?("aaaaaaaa")   // false

Calculate the check digit for a partial GTIN string

    Gtin::Gtin.calculate_check_digit("73409230943") // 6

Create a GTIN string from a partial string

    Gtin::with_check_digit("73409230943") // 734092309436

Parse a string to a GTIN object

    gtin = Gtin::Gtin.create("734092309436")

Convert a GTIN object back to a string

    gtin.to_s

Add gtin.rb to your application's Gemfile:

    gem 'gtin.rb'

And then execute:

    bundle

Or install it on your system  with

    gem install gtin.rb

## Getting Started

Install the development dependencies

    ../gradlew init

Or directly with bundler

    bundle install

## Building

To build the library and run all unit tests use

    ../gradlew clean build

Alternatively run rake directly with

    rake

To view coverage report open

    coverage/index.html

## Coverage

Code coverage is automatically sent to [coveralls.io](https://coveralls.io) when tests are run on Travis CI.

## Publishing

The gtin.rb library is published to [RubyGems](https://rubygems.org).

Make sure you have [created a RubyGems account](https://docs.npmjs.com/misc/developers).

With this configuration in place a deployment can be started with

    ../gradlew publish

Or directly with rake

    rake publish

You will be prompted for your credentials when necessary.
