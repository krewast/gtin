# gtin4j

A Java library for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes.

[![Build Status](https://travis-ci.org/powa/gtin.svg?branch=master)](https://travis-ci.org/powa/gtin) [![Coverage Status](https://coveralls.io/repos/powa/gtin/badge.svg?branch=master&service=github)](https://coveralls.io/github/powa/gtin?branch=master) [![Download](https://api.bintray.com/packages/powa/maven/gtin/images/download.svg)](https://bintray.com/powa/maven/gtin/_latestVersion)

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

Add gtin4j as a dependency of your application with

Maven

    <repositories>
        <repository>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
            <id>bintray-powa-maven</id>
            <name>bintray</name>
            <url>http://dl.bintray.com/powa/maven</url>
        </repository>
    </repositories>
    <pluginRepositories>
        <pluginRepository>
            <snapshots>
                <enabled>false</enabled>
            </snapshots>
            <id>bintray-powa-maven</id>
            <name>bintray-plugins</name>
           <url>http://dl.bintray.com/powa/maven</url>
        </pluginRepository>
    </pluginRepositories>
    <dependencies>
        <dependency>
            <group>com.powa</group>
            <artifactId>gtin</artifactId>
            <version>1.0.4</version>
        </dependency>
    </dependencies>

Gradle

    repositories {
        maven {
            url  "http://dl.bintray.com/powa/maven"
        }
    }
    dependencies {
        compile 'com.powa:gtin:1.0.4'
    }

## Building

To build the library and run all unit tests use

    ./gradlew clean build

View coverage report

    ./gradlew jacocoTestReport

## Deploying

The gtin4j library is deployed through Bintray.

The credentials for signing and upload are supplied through environment variables.
Set `BINTRAY_USER` to your Bintray username `BINTRAY_KEY` to your API key.

With this configuration in place a deployment can be started with

    ./gradlew uploadArchives

You then need to manually log into [Bintray](https://bintray.com/powa/maven/gtin/view) and publish the archives to make them publicly available.

It is recommended you go to the 'Files' section of the latest version and add the `gtin-x.y.z.jar` to the download list using the 'Actions' menu.
