#!/bin/sh
xcodebuild clean -project GTINObjc.xcodeproj/ \
-scheme 'gtin.objc' \
-sdk iphonesimulator \
-configuration Debug | xcpretty -c
