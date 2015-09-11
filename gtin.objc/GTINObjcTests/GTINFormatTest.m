/**
 * Copyright (C) 2015 Powa Technologies Ltd.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <GTINObjc/GTINObjc.h>

@interface GTINFormatTest : XCTestCase

@end

@implementation GTINFormatTest

- (void)testForLength7ShouldThrowException {
    XCTAssertThrowsSpecificNamed(GTINFormatForLength(7), NSException, NSRangeException);
}

- (void)testForLength8ShouldReturnGtin8 {
    XCTAssertEqual(GTINFormatGTIN_8, GTINFormatForLength(8));
}

- (void)testForLength9ShouldThrowException {
    XCTAssertThrowsSpecificNamed(GTINFormatForLength(9), NSException, NSRangeException);
}

- (void)testForLength11ShouldThrowException {
    XCTAssertThrowsSpecificNamed(GTINFormatForLength(11), NSException, NSRangeException);
}

- (void)testForLength12ShouldReturnGtin12 {
    XCTAssertEqual(GTINFormatGTIN_12, GTINFormatForLength(12));
}

- (void)testForLength13ShouldReturnGtin13 {
    XCTAssertEqual(GTINFormatGTIN_13, GTINFormatForLength(13));
}

- (void)testForLength14ShouldReturnGtin14 {
    XCTAssertEqual(GTINFormatGTIN_14, GTINFormatForLength(14));
}

- (void)testForLength15ShouldThrowException {
    XCTAssertThrowsSpecificNamed(GTINFormatForLength(15), NSException, NSRangeException);
}

- (void)testValueOf {
    XCTAssertEqual(GTINFormatGTIN_8, GTINFormatForName(@"GTINFormatGTIN_8"));
    XCTAssertEqual(GTINFormatGTIN_12, GTINFormatForName(@"GTINFormatGTIN_12"));
    XCTAssertEqual(GTINFormatGTIN_13, GTINFormatForName(@"GTINFormatGTIN_13"));
    XCTAssertEqual(GTINFormatGTIN_14, GTINFormatForName(@"GTINFormatGTIN_14"));
}

- (void)testValueOfUnknownValueShouldThrowException {
    XCTAssertThrowsSpecificNamed(GTINFormatForName(@"GTINFormatGTIN_15"), NSException, NSRangeException);
}

- (void)testDescriptionShouldReturnReadableNames {
    XCTAssertEqualObjects(@"GTIN-8", GTINFormatDescription(GTINFormatGTIN_8));
    XCTAssertEqualObjects(@"GTIN-12", GTINFormatDescription(GTINFormatGTIN_12));
    XCTAssertEqualObjects(@"GTIN-13", GTINFormatDescription(GTINFormatGTIN_13));
    XCTAssertEqualObjects(@"GTIN-14", GTINFormatDescription(GTINFormatGTIN_14));
}

@end
