#!/bin/sh
xcodebuild clean -project GTINObjc.xcodeproj/ \
-scheme 'gtin.objc' \
-configuration Debug \
-destination 'platform=iOS Simulator,name=iPhone 6,OS=8.4' | xcpretty -c
