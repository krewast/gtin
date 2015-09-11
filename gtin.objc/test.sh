#!/bin/sh
# First Run Tests
xcodebuild test -project GTINObjc.xcodeproj/ \
-scheme 'gtin.objc' \
-configuration Debug \
-destination 'platform=iOS Simulator,name=iPhone 6,OS=8.4' | xcpretty -c

#Above we're piping output through xcpretty, which is not required
#but very nice! (gem install xcpretty)

# Now Produce Test Coverage Report
groovy frankencover -source-dir GTINObjc \
-required-coverage 95
