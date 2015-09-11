#!/bin/sh
# First Run Tests
xcodebuild test -project GTINObjc.xcodeproj/ \
-scheme 'gtin.objc' \
-sdk iphonesimulator \
-configuration Debug | xcpretty -c

#Above we're piping output through xcpretty, which is not required
#but very nice! (gem install xcpretty)

# Now Produce Test Coverage Report
groovy frankencover -source-dir GTINObjc \
-required-coverage 95
