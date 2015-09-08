# gtin.java

A Java library for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes.

[ ![Download](https://api.bintray.com/packages/powa/maven/gtin.java/images/download.svg) ](https://bintray.com/powa/maven/gtin.java/_latestVersion)

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

    Gtin gtin = GTIN.create("734092309436");

Convert a GTIN object back to a string

    gtin.toString();

Add gtin.java as a dependency of your application with

Maven

    <repositories>
        <repository>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
            <id>jcenter</id>
            <name>jcenter</name>
            <url>http://jcenter.bintray.com</url>
        </repository>
    </repositories>
    <dependencies>
        <dependency>
            <group>com.powa</group>
            <artifactId>gtin.java</artifactId>
            <version>1.1.1</version>
        </dependency>
    </dependencies>

Gradle

    repositories {
        jcenter()
    }
    dependencies {
        compile 'com.powa:gtin.java:1.1.1'
    }

## Getting Started

Install the development dependencies (currently none)

    ../gradlew init

## Building

To build the library and run all unit tests use

    ../gradlew clean build

Generate coverage report

    ../gradlew jacocoTestReport

## Coverage

Generate coverage and send to [coveralls.io](https://coveralls.io)

   ../gradlew coverage

## Publishing

The gtin.java library is published to JCenter through [Bintray](https://bintray.com)..

The credentials for signing and upload are supplied through environment variables.
Set `BINTRAY_USER` to your Bintray username `BINTRAY_KEY` to your API key.

With this configuration in place a deployment can be started with

    ../gradlew publish

You then need to manually log into [Bintray](https://bintray.com/powa/maven/gtin/view) and publish the archives to make them publicly available.

It is recommended you go to the 'Files' section of the latest version and add the `gtin.java-x.y.z.jar` to the download list using the 'Actions' menu.
