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

#import <Foundation/Foundation.h>
#import "GTINFormat.h"
#import "GTINFormatException.h"

@interface GTIN : NSObject<NSCoding>

/**
 * @return the format or type of this GTIN.
 */
@property (nonatomic, readonly) GTINFormat format;

/**
 * Creates a GTIN from the given string.
 * You may use the {@link #isValid(String)} method first if you are unsure whether the
 * string is a valid GTIN to avoid a GTINFormatException being thrown.
 *
 * @param gtin the GTIN string.
 * @return a GTIN object if the string is a valid GTIN.
 * @throws GTINFormatException if the string is not a valid GTIN.
 */
+ (GTIN *)gtin:(NSString *)gtin;

/**
 * Creates a GTIN from the given partial GTIN string without the check digit.
 *
 * @param gtinWithoutCheckDigit the GTIN without the final check digit.
 * @return a GTIN object if the string is a valid GTIN.
 * @throws GTINFormatException if the string is not a valid partial GTIN.
 */
+ (GTIN *)gtinWithGTINWithoutCheckDigit:(NSString *)gtinWithoutCheckDigit;

/**
 * Checks if the string is a valid GTIN by checking the format and checksum.
 *
 * @param gtin the GTIN string to check, may be GTIN-8, GTIN-12, GTIN-13 or GTIN-14 format.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
+ (BOOL)isValidString:(NSString *)gtin;

/**
 * Checks if the string is a valid specific GTIN format by checking the format, length
 * and checksum.
 *
 * @param gtin the GTIN string to check, may be GTIN-8, GTIN-12, GTIN-13 or GTIN-14 format.
 * @param format the GTIN format to check the string against.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
+ (BOOL)isValidString:(NSString *)gtin forFormat:(GTINFormat)format;

/**
 * Checks if the string is a valid GTIN-8 by checking the format and checksum.
 *
 * @param gtin the GTIN-8 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
+ (BOOL)isValidString8:(NSString *)gtin;

/**
 * Checks if the string is a valid GTIN-12 by checking the format and checksum.
 *
 * @param gtin the GTIN-12 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
+ (BOOL)isValidString12:(NSString *)gtin;

/**
 * Checks if the string is a valid GTIN-13 by checking the format and checksum.
 *
 * @param gtin the GTIN-13 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
+ (BOOL)isValidString13:(NSString *)gtin;

/**
 * Checks if the string is a valid GTIN-14 by checking the format and checksum.
 *
 * @param gtin the GTIN-14 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
+ (BOOL)isValidString14:(NSString *)gtin;

/**
 * Calculates the check digit for a partial GTIN.
 *
 * @param gtinWithoutCheckDigit the GTIN without the final check digit.
 * @return the check digit to complete the GTIN code.
 * @throws GtinFormatException if the string is not a valid partial GTIN without the check
 * digit.
 */
+ (int)calculateCheckDigitWithGTINWithoutCheckDigit:(NSString *)gtinWithoutCheckDigit;

/**
 * Returns the given partial GTIN code with check digit added.
 *
 * @param gtinWithoutCheckDigit the GTIN without the final check digit.
 * @return the GTIN code with check digit.
 * @throws GtinFormatException if the string is not a valid partial GTIN without the check
 * digit.
 */
+ (NSString *)stringWithCheckDigitWithGTINWithoutCheckDigit:(NSString *)gtinWithoutCheckDigit;

/**
 * Checks whether the input string matches any GTIN format, i.e. is of the correct length for
 * a GTIN and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
+ (BOOL)stringMatchesFormat:(NSString *)gtin;

/**
 * Checks whether the input string matches the GTIN format, i.e. is of the correct length for
 * a GTIN and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
+ (BOOL)stringMatchesFormat:(NSString *)gtin format:(GTINFormat)format;

/**
 * Checks whether the input string matches the specific GTIN format, i.e. is of the correct
 * length that format GTIN and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @param format the GTIN format to check the string against.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
+ (BOOL)stringMatchesFormat8:(NSString *)gtin;

/**
 * Checks whether the input string matches the GTIN-12 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
+ (BOOL)stringMatchesFormat12:(NSString *)gtin;

/**
 * Checks whether the input string matches the GTIN-13 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
+ (BOOL)stringMatchesFormat13:(NSString *)gtin;

/**
 * Checks whether the input string matches the GTIN-14 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
+ (BOOL)stringMatchesFormat14:(NSString *)gtin;

/**
 * @return the length of this GTIN.
 */
- (NSUInteger)length;

/**
 * @return the check digit of this GTIN.
 */
- (int)checkDigit;

/**
 * Gets the digit at the specified position.
 *
 * @param position the position, from 0 to length - 1.
 * @return the digit at the specified position.
 * @throws java.lang.IndexOutOfBoundsException if the position is not between 0 and length - 1.
 */
- (int)digitAtPosition:(NSUInteger)position;

/**
 * @return this GTIN code as a string.
 */
- (NSString *)description;

- (BOOL)isEqual:(id)obj;

- (BOOL)isEqualToGTIN:(GTIN *)gtin;

- (BOOL)isEqualToString:(NSString *)gtin;

- (NSUInteger)hash;

@end
