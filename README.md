# GTIN Library for Java

A library for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes.

[![Build status](https://travis-ci.org/powa/gtin.svg?branch=master)](https://travis-ci.org/powa/gtin) [![Download](https://api.bintray.com/packages/powa/maven/gtin/images/download.svg)](https://bintray.com/powa/maven/gtin/_latestVersion)

## Using

Check if a string is a valid GTIN by validating the checksum

    GTIN.isValid("734092309436");

See if a string matches the general GTIN format

    GTIN.matchesFormat("00000000");

Parse a string to a GTIN object

    GTIN gtin = GTIN.parse("734092309436");

Convert a GTIN object back to a string

    String str = gtin.toString();

Add the GTIN library as a dependency of your application with

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
            <version>1.0.1</version>
        </dependency>
    </dependencies>

Gradle

    repositories {
        maven {
            url  "http://dl.bintray.com/powa/maven"
        }
    }
    dependencies {
        compile 'com.powa:gtin:1.0.1'
    }

## Building

To build the library and run all unit tests use

    ./gradlew clean build

## Deploying

The gtin library is deployed through Bintray.

The credentials for signing and upload are supplied through environment variables.
Set `BINTRAY_USER` to your Bintray username `BINTRAY_KEY` to your API key.

With this configuration in place a deployment can be started with

    ./gradlew uploadArchives
