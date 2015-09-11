#!/bin/sh
xcodebuild build -project GTINObjc.xcodeproj/ \
-scheme 'gtin.objc' \
-sdk iphonesimulator \
-configuration Debug | xcpretty -c
