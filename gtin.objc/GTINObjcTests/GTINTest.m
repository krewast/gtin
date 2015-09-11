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

@interface GTINTest : XCTestCase

@end

@implementation GTINTest


- (void)testStringOf7DigitsShouldNotBeValid {
    NSString *digits7 = @"0123456";
    
    XCTAssertFalse([GTIN isValidString:digits7]);
}

- (void)testGtin8ShouldBeValid {
    NSString *gtin8 = @"73513537";
    
    XCTAssertTrue([GTIN isValidString:gtin8]);
}

- (void)testStringOf8LettersShouldNotBeValid {
    NSString *letters8 = @"abcdefgh";
    
    XCTAssertFalse([GTIN isValidString:letters8]);
}

- (void)testGtin8WithInvalidCheckDigitShouldNotBeValid {
    NSString *badGtin8 = @"73513536";
    
    XCTAssertFalse([GTIN isValidString:badGtin8]);
}

- (void)testGtin12ShouldBeValid {
    NSString *gtin12 = @"123456789012";
    
    XCTAssertTrue([GTIN isValidString:gtin12]);
}

- (void)testGtin12WithInvalidCheckDigitShouldNotBeValid {
    NSString *badGtin12 = @"123456789010";
    
    XCTAssertFalse([GTIN isValidString:badGtin12]);
}

- (void)testGtin13ShouldBeValid {
    NSString *gtin13 = @"4006381333931";
    
    XCTAssertTrue([GTIN isValidString:gtin13]);
}

- (void)testGtin13WithInvalidCheckDigitShouldNotBeValid {
    NSString *badGtin13 = @"4006381333932";
    
    XCTAssertFalse([GTIN isValidString:badGtin13]);
}

- (void)testGtin14ShouldBeValid {
    NSString *gtin14 = @"10614141000415";
    
    XCTAssertTrue([GTIN isValidString:gtin14]);
}

- (void)testGtin14WithInvalidCheckDigitShouldNotBeValid {
    NSString *badGtin14 = @"10614141000416";
    
    XCTAssertFalse([GTIN isValidString:badGtin14]);
}

- (void)validateNullShouldThrowException {
    XCTAssertThrowsSpecificNamed([GTIN isValidString:nil], NSException, NSInvalidArgumentException);
}

- (void)testGtin8ShouldBeValid8 {
    NSString *gtin8 = @"03485736";
    
    XCTAssertTrue([GTIN isValidString8:gtin8]);
}

- (void)testGtin14ShouldNotBeValid8 {
    NSString *gtin14 = @"34957354738950";
    
    XCTAssertFalse([GTIN isValidString8:gtin14]);
}

- (void)testGtin12ShouldBeValid12 {
    NSString *gtin12 = @"734092309436";
    
    XCTAssertTrue([GTIN isValidString12:gtin12]);
}

- (void)testGtin13ShouldBeValid13 {
    NSString *gtin13 = @"0234248273487";
    
    XCTAssertTrue([GTIN isValidString13:gtin13]);
}

- (void)testGtin14ShouldBeValid14 {
    NSString *gtin14 = @"34957354738950";
    
    XCTAssertTrue([GTIN isValidString14:gtin14]);
}

- (void)testGtin13ShouldNotBeValid14 {
    NSString *gtin13 = @"0234248273487";
    
    XCTAssertFalse([GTIN isValidString14:gtin13]);
}

- (void)testStringOf7DigitsShouldNotMatchFormat {
    NSString *digits7 = @"0123456";
    
    XCTAssertFalse([GTIN stringMatchesFormat:digits7]);
}

- (void)testStringOf8DigitsShouldMatchFormat {
    NSString *digits8 = @"01234567";
    
    XCTAssertTrue([GTIN stringMatchesFormat:digits8]);
}

- (void)teststringOf8LettersShouldNotMatchFormat {
    NSString *letters8 = @"abcdefgh";
    
    XCTAssertFalse([GTIN stringMatchesFormat:letters8]);
}

- (void)testStringOf8LettersAndDigitsShouldNotMatchFormat {
    NSString *lettersAndDigits8 = @"0a1b2c3d";
    
    XCTAssertFalse([GTIN stringMatchesFormat:lettersAndDigits8]);
}

- (void)testStringOf9DigitsShouldNotMatchFormat {
    NSString *digits9 = @"012345678";
    
    XCTAssertFalse([GTIN stringMatchesFormat:digits9]);
}

- (void)testStringOf11DigitsShouldNotMatchFormat {
    NSString *digits11 = @"01234567890";
    
    XCTAssertFalse([GTIN stringMatchesFormat:digits11]);
}

- (void)testStringOf12DigitsShouldMatchFormat {
    NSString *digits12 = @"012345678901";
    
    XCTAssertTrue([GTIN stringMatchesFormat:digits12]);
}

- (void)testStringOf12LettersShouldNotMatchFormat {
    NSString *letters12 = @"abcdefghijkl";
    
    XCTAssertFalse([GTIN stringMatchesFormat:letters12]);
}

- (void)teststringOf12LettersAndDigitsShouldNotMatchFormat {
    NSString *lettersAndDigits12 = @"0a1b2c3d4e5f6g";
    
    XCTAssertFalse([GTIN stringMatchesFormat:lettersAndDigits12]);
}

- (void)teststringOf13DigitsShouldMatchFormat {
    NSString *digits13 = @"0123456789012";
    
    XCTAssertTrue([GTIN stringMatchesFormat:digits13]);
}

- (void)testStringOf13LettersShouldNotMatchFormat {
    NSString *letters13 = @"abcdefghijklm";
    
    XCTAssertFalse([GTIN stringMatchesFormat:letters13]);
}

- (void)testStringOf13LettersAndDigitsShouldNotMatchFormat {
    NSString *lettersAndDigits13 = @"0a1b2c3d4e5f6g7";
    
    XCTAssertFalse([GTIN stringMatchesFormat:lettersAndDigits13]);
}

- (void)testStringOf14DigitsShouldMatchFormat {
    NSString *digits14 = @"01234567890123";
    
    XCTAssertTrue([GTIN stringMatchesFormat:digits14]);
}

- (void)testStringOf14LettersShouldNotMatchFormat {
    NSString *letters14 = @"abcdefghijklmn";
    
    XCTAssertFalse([GTIN stringMatchesFormat:letters14]);
}

- (void)testStringOf14LettersAndDigitsShouldNotMatchFormat {
    NSString *lettersAndDigits14 = @"0a1b2c3d4e5f6g7h";
    
    XCTAssertFalse([GTIN stringMatchesFormat:lettersAndDigits14]);
}

- (void)testStringOf15DigitsShouldNotMatchFormat {
    NSString *digits15 = @"012345678901234";
    
    XCTAssertFalse([GTIN stringMatchesFormat:digits15]);
}

- (void)testStringOf14DigitsShouldMatchSpecificGtinFormat {
    NSString *digits14 = @"01234567890123";
    
    XCTAssertTrue([GTIN stringMatchesFormat:digits14 format:GTINFormatGTIN_14]);
}

- (void)testStringOf8DigitsShouldMatchFormat8 {
    NSString *digits8 = @"01234567";
    
    XCTAssertTrue([GTIN stringMatchesFormat8:digits8]);
}

- (void)testStringOf12DigitsShouldMatchFormat12 {
    NSString *digits12 = @"012345678901";
    
    XCTAssertTrue([GTIN stringMatchesFormat12:digits12]);
}

- (void)testStringOf8DigitsShouldNotMatchFormat12 {
    NSString *digits8 = @"01234567";
    
    XCTAssertFalse([GTIN stringMatchesFormat12:digits8]);
}

- (void)testStringOf13DigitsShouldMatchFormat13 {
    NSString *digits13 = @"0123456789012";
    
    XCTAssertTrue([GTIN stringMatchesFormat13:digits13]);
}

- (void)testStringOf12DigitsShouldNotMatchFormat13 {
    NSString *digits12 = @"012345678901";
    
    XCTAssertFalse([GTIN stringMatchesFormat13:digits12]);
}

- (void)testStringOf14DigitsShouldNotMatchFormat13 {
    NSString *digits14 = @"01234567890123";
    
    XCTAssertFalse([GTIN stringMatchesFormat13:digits14]);
}

- (void)testStringOf14DigitsShouldMatchFormat14 {
    NSString *digits14 = @"01234567890123";
    
    XCTAssertTrue([GTIN stringMatchesFormat14:digits14]);
}

- (void)testStringOf13DigitsShouldNotMatchFormat14 {
    NSString *digits13 = @"0123456789012";
    
    XCTAssertFalse([GTIN stringMatchesFormat14:digits13]);
}

- (void)testGtin8ShouldParseToGtin {
    NSString *gtin8 = @"03485736";
    
    GTIN *gtin = [GTIN gtin:gtin8];
    
    XCTAssertEqual(GTINFormatGTIN_8, gtin.format);
    XCTAssertEqual(8, gtin.length);
    XCTAssertEqualObjects(gtin8, [gtin description]);
}

- (void)testGtin8WithInvalidCheckDigitShouldNotParseToGtin {
    NSString *badGtin8 = @"73513536";
    
    XCTAssertThrowsSpecificNamed([GTIN gtin:badGtin8], NSException, GTINFormatException);
}

- (void)testGtin12ShouldParseToGtin {
    NSString *gtin12 = @"734092309436";
    
    GTIN *gtin = [GTIN gtin:gtin12];
    
    XCTAssertEqual(GTINFormatGTIN_12, gtin.format);
    XCTAssertEqual(12, gtin.length);
    XCTAssertEqualObjects(gtin12, gtin.description);
}

- (void)testGtin12WithInvalidCheckDigitShouldNotParseToGtin {
    NSString *badGtin12 = @"123456789010";
    
    XCTAssertThrowsSpecificNamed([GTIN gtin:badGtin12], NSException, GTINFormatException);
}

- (void)testGtin13ShouldParseToGtin {
    NSString *gtin13 = @"0234248273487";
    
    GTIN *gtin = [GTIN gtin:gtin13];
    
    XCTAssertEqual(GTINFormatGTIN_13, gtin.format);
    XCTAssertEqual(13, gtin.length);
    XCTAssertEqualObjects(gtin13, gtin.description);
}

- (void)testGtin13WithInvalidCheckDigitShouldNotParseToGtin {
    NSString *badGtin13 = @"4006381333932";
    
    XCTAssertThrowsSpecificNamed([GTIN gtin:badGtin13], NSException, GTINFormatException);
}

- (void)testGtin14ShouldParseToGtin {
    NSString *gtin14 = @"10614141000415";
    
    GTIN *gtin = [GTIN gtin:gtin14];
    
    XCTAssertEqual(GTINFormatGTIN_14, gtin.format);
    XCTAssertEqual(14, gtin.length);
    XCTAssertEqualObjects(gtin14, gtin.description);
}

- (void)testGtin14WithInvalidCheckDigitShouldNotParseToGtin {
    NSString *badGtin14 = @"10614141000416";
    
    XCTAssertThrowsSpecificNamed([GTIN gtin:badGtin14], NSException, GTINFormatException);
}

- (void)testCreateNullShouldThrowException {
    XCTAssertThrowsSpecificNamed([GTIN gtin:nil], NSException, NSInvalidArgumentException);
}

- (void)testGtinShouldBeEqualToItself {
    NSString *gtin14 = @"10614141000415";
    GTIN *gtin = [GTIN gtin:gtin14];
    
    XCTAssertTrue([gtin isEqual:gtin]);
    XCTAssertTrue([gtin isEqualToGTIN:gtin]);
}

- (void)testGtinShouldBeEqualToString {
    NSString *gtin14 = @"10614141000415";
    GTIN *gtin = [GTIN gtin:gtin14];
    
    XCTAssertTrue([gtin isEqualToString:gtin14]);
}

- (void)testSameGtinsShouldBeEqual {
    NSString *gtin14 = @"10614141000415";
    GTIN *gtin1 = [GTIN gtin:gtin14];
    GTIN *gtin2 = [GTIN gtin:gtin14];
    
    XCTAssertTrue([gtin1 isEqual:gtin2]);
    XCTAssertTrue([gtin2 isEqual:gtin1]);
}

- (void)testDifferentGtinsShouldNotBeEqual {
    NSString *gtin13 = @"0234248273487";
    NSString *gtin14 = @"10614141000415";
    GTIN *gtin1 = [GTIN gtin:gtin14];
    GTIN *gtin2 = [GTIN gtin:gtin13];
    
    XCTAssertFalse([gtin1 isEqual:gtin2]);
    XCTAssertFalse([gtin1 isEqualToGTIN:gtin2]);
    XCTAssertFalse([gtin2 isEqual:gtin1]);
}

- (void)testGtinShouldNotBeEqualToObjectOfDifferentType {
    NSString *gtin14 = @"10614141000415";
    GTIN *gtin = [GTIN gtin:gtin14];
    
    XCTAssertFalse([gtin isEqual:gtin14]);
    XCTAssertFalse([gtin isEqual:[NSObject new]]);
}

- (void)testGtinHashCodeShouldBeConstant {
    NSString *gtin14 = @"10614141000415";
    GTIN *gtin = [GTIN gtin:gtin14];
    
    NSUInteger hashCode1 = [gtin hash];
    NSUInteger hashCode2 = [gtin hash];
    
    XCTAssertEqual(hashCode1, hashCode2);
}

- (void)testSameGtinsShouldHaveEqualHashCodes {
    NSString *gtin14 = @"10614141000415";
    GTIN *gtin1 = [GTIN gtin:gtin14];
    GTIN *gtin2 = [GTIN gtin:gtin14];
    
    XCTAssertEqual([gtin1 hash], [gtin2 hash]);
}

- (void)testDifferentGtinsShouldHaveUnequalHashCodesIfPossible {
    GTIN *gtin1 = [GTIN gtin:@"10614141000415"];
    GTIN *gtin2 = [GTIN gtin:@"34957354738950"];
    
    XCTAssertNotEqual([gtin1 hash], [gtin2 hash]);
}

- (void)testGtin8CalculatedCheckDigitShouldBeCorrect {
    NSString *partialGtin8 = @"7351353";
    
    int checkDigit = [GTIN calculateCheckDigitWithGTINWithoutCheckDigit:partialGtin8];
    
    XCTAssertEqual(7, checkDigit);
}

- (void)testGtin12CalculatedCheckDigitShouldBeCorrect {
    NSString *partialGtin12 = @"73409230943";

    int checkDigit = [GTIN calculateCheckDigitWithGTINWithoutCheckDigit:partialGtin12];
    
    XCTAssertEqual(6, checkDigit);
}

- (void)testGtin13CalculatedCheckDigitShouldBeCorrect {
    NSString *partialGtin13 = @"295248972349";
    
    int checkDigit = [GTIN calculateCheckDigitWithGTINWithoutCheckDigit:partialGtin13];
    
    XCTAssertEqual(0, checkDigit);
}

- (void)testGtin14CalculatedCheckDigitShouldBeCorrect {
    NSString *partialGtin14 = @"1061414100041";
    
    int checkDigit = [GTIN calculateCheckDigitWithGTINWithoutCheckDigit:partialGtin14];
    
    XCTAssertEqual(5, checkDigit);
}

-(void)testStringOfLettersCheckDigitShouldThrowException {
    NSString *letters7 = @"abcdefg";
    
    XCTAssertThrowsSpecificNamed([GTIN calculateCheckDigitWithGTINWithoutCheckDigit:letters7], NSException, GTINFormatException);
}

- (void)testCalculateCheckDigitNullShouldThrowException {
    XCTAssertThrowsSpecificNamed([GTIN calculateCheckDigitWithGTINWithoutCheckDigit:nil], NSException, NSInvalidArgumentException);
}

- (void)testGtin8WithCheckDigitShouldBeCorrect {
    NSString *partialGtin8 = @"7351353";
    
    NSString *gtin8 = [GTIN stringWithCheckDigitWithGTINWithoutCheckDigit:partialGtin8];
    
    XCTAssertEqualObjects(@"73513537", gtin8);
}

- (void)testStringOfLettersWithCheckDigitShouldThrowException {
    NSString *letters7 = @"abcdefg";
    
    XCTAssertThrowsSpecificNamed([GTIN stringWithCheckDigitWithGTINWithoutCheckDigit:letters7], NSException, GTINFormatException);
}

- (void)testGtin12WithCheckDigitShouldBeCorrect {
    NSString *partialGtin12 = @"73409230943";
    
    NSString *gtin12 = [GTIN stringWithCheckDigitWithGTINWithoutCheckDigit:partialGtin12];
    
    XCTAssertEqualObjects(@"734092309436", gtin12);
}

- (void)testGtin13WithCheckDigitShouldBeCorrect {
    NSString *partialGtin13 = @"023424827348";
    
    NSString *gtin13 = [GTIN stringWithCheckDigitWithGTINWithoutCheckDigit:partialGtin13];
    
    XCTAssertEqualObjects(@"0234248273487", gtin13);
}

- (void)testGtin14WithCheckDigitShouldBeCorrect {
    NSString *partialGtin14 = @"1061414100041";
    
    NSString *gtin14 = [GTIN stringWithCheckDigitWithGTINWithoutCheckDigit:partialGtin14];
    
    XCTAssertEqualObjects(@"10614141000415", gtin14);
}

- (void)withNullCheckDigitShouldThrowException {
    [GTIN gtinWithGTINWithoutCheckDigit:nil];
}

- (void)testGtin14CreateWithCheckDigitShouldBeCorrect {
    NSString *partialGtin14 = @"1061414100041";
    
    GTIN *gtin14 = [GTIN gtinWithGTINWithoutCheckDigit:partialGtin14];
    
    XCTAssertEqualObjects(@"10614141000415", [gtin14 description]);
}

- (void)createWithNullCheckDigitShouldThrowException {
    XCTAssertThrowsSpecificNamed([GTIN gtinWithGTINWithoutCheckDigit:nil], NSException, NSInvalidArgumentException);
}

- (void)testGtin14CheckDigitShouldBeCorrect {
    NSString *gtin14 = @"10614141000415";
    GTIN *gtin = [GTIN gtin:gtin14];
    
    XCTAssertEqual(5, [gtin checkDigit]);
}

- (void)testGtinDigitAtShouldBeCorrect {
    NSString *gtin14 = @"10614141000415";
    GTIN *gtin = [GTIN gtin:gtin14];
    
    XCTAssertEqual(1, [gtin digitAtPosition:0]);
    XCTAssertEqual(0, [gtin digitAtPosition:1]);
    XCTAssertEqual(6, [gtin digitAtPosition:2]);
    XCTAssertEqual(1, [gtin digitAtPosition:12]);
    XCTAssertEqual(5, [gtin digitAtPosition:13]);
}

- (void)testGtinAndDeserializedGtinShouldBeEqual {
    NSString *gtin14 = @"10614141000415";
    
    GTIN *gtin = [GTIN gtin:gtin14];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:gtin];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"gtin"];
    NSData *deserializedData = [[NSUserDefaults standardUserDefaults] objectForKey:@"gtin"];
    GTIN *deserializedGtin = [NSKeyedUnarchiver unarchiveObjectWithData:deserializedData];
    
    XCTAssertEqualObjects(gtin, deserializedGtin);
    XCTAssertEqualObjects(gtin.description, deserializedGtin.description);
    XCTAssertEqual(gtin.format, deserializedGtin.format);
    XCTAssertEqual(gtin.length, deserializedGtin.length);
}

@end
