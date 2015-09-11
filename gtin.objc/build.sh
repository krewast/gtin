#!/bin/sh
xcodebuild build -project GTINObjc.xcodeproj/ \
-scheme 'gtin.objc' \
-configuration Debug | xcpretty -c
