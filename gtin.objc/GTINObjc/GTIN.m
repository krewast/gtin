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

#import "GTIN.h"

@interface GTIN()

@property (nonatomic, strong, readwrite) NSString *gtin;
// Redeclare as readwrite
@property (nonatomic, readwrite) GTINFormat format;

@end

@implementation GTIN

#define kGtinKey       @"gtin"

- (id)initWithCoder:(NSCoder *)decoder {
    NSString *gtin = [decoder decodeObjectForKey:kGtinKey];
    
    GTIN *g = [GTIN new];
    g.gtin = gtin;
    g.format = GTINFormatForLength(gtin.length);
    
    return g;
}

+ (GTIN *)gtin:(NSString *)gtin {
    if (![GTIN isValidString:gtin]) {
        @throw [NSException exceptionWithName:GTINFormatException reason:[NSString stringWithFormat:@"String %@ is not a valid gtin", gtin] userInfo:nil];
    }
    
    GTIN *g = [GTIN new];
    g.gtin = gtin;
    g.format = GTINFormatForLength(gtin.length);
    
    return g;
}

+ (GTIN *)gtinWithGTINWithoutCheckDigit:(NSString *)gtinWithoutCheckDigit {
    NSString *gtin = [GTIN stringWithCheckDigitWithGTINWithoutCheckDigit:gtinWithoutCheckDigit];
    GTIN *g = [GTIN new];
    g.gtin = gtin;
    g.format = GTINFormatForLength(gtin.length);
    
    return g;
}

+ (BOOL)isValidString:(NSString *)gtin {
    return [GTIN isValidString:gtin forFormat:GTINFormatCount()];
}

+ (BOOL)isValidString:(NSString *)gtin forFormat:(GTINFormat)format {
    // Check format of barcode for validity
    if (![GTIN stringMatchesFormat:gtin]) {
        return false;
    }
    
    NSUInteger gtinLength = gtin.length;
    if (format != GTINFormatCount() && gtinLength != GTINFormatLength(format)) {
        return false;
    }
    
    int checkSum = 0;
    int weightBit = gtinLength % 2;
    for (int i = 0; i < gtinLength; i++) {
        int weight = i % 2 == weightBit ? 3 : 1;
        checkSum += [[gtin substringWithRange:NSMakeRange(i, 1)] intValue] * weight;
    }
    
    return checkSum % 10 == 0;
}

+ (BOOL)isValidString8:(NSString *)gtin {
    return [GTIN isValidString:gtin forFormat:GTINFormatGTIN_8];
}

+ (BOOL)isValidString12:(NSString *)gtin {
    return [GTIN isValidString:gtin forFormat:GTINFormatGTIN_12];
}

+ (BOOL)isValidString13:(NSString *)gtin {
    return [GTIN isValidString:gtin forFormat:GTINFormatGTIN_13];
}

+ (BOOL)isValidString14:(NSString *)gtin {
    return [GTIN isValidString:gtin forFormat:GTINFormatGTIN_14];
}

+ (int)calculateCheckDigitWithGTINWithoutCheckDigit:(NSString *)gtinWithoutCheckDigit {
    if (![GTIN stringMatchesFormat:gtinWithoutCheckDigit format:GTINFormatCount() offset:1]) {
        @throw [NSException exceptionWithName:GTINFormatException reason:[NSString stringWithFormat:@"String %@ is not a valid partial gtin", gtinWithoutCheckDigit] userInfo:nil];
    }
    
    int checkSum = 0;
    NSUInteger gtinLength = gtinWithoutCheckDigit.length;
    int weightBit = (gtinLength + 1) % 2;
    for (int i = 0; i < gtinLength; i++) {
        int weight = i % 2 == weightBit ? 3 : 1;
        checkSum += [[gtinWithoutCheckDigit substringWithRange:NSMakeRange(i, 1)] intValue] * weight;
    }
    
    return checkSum % 10 == 0 ? 0 : 10 - (checkSum % 10);
}

+ (NSString *)stringWithCheckDigitWithGTINWithoutCheckDigit:(NSString *)gtinWithoutCheckDigit {
    return [NSString stringWithFormat:@"%@%d", gtinWithoutCheckDigit,
            [GTIN calculateCheckDigitWithGTINWithoutCheckDigit:gtinWithoutCheckDigit]];
}

+ (BOOL)stringMatchesFormat:(NSString *)gtin {
    return [GTIN stringMatchesFormat:gtin format:GTINFormatCount() offset:0];
}

+ (BOOL)stringMatchesFormat:(NSString *)gtin format:(GTINFormat)format {
    return [GTIN stringMatchesFormat:gtin format:format offset:0];
}

+ (BOOL)stringMatchesFormat8:(NSString *)gtin {
    return [GTIN stringMatchesFormat:gtin format:GTINFormatGTIN_8 offset:0];
}

+ (BOOL)stringMatchesFormat12:(NSString *)gtin {
    return [GTIN stringMatchesFormat:gtin format:GTINFormatGTIN_12 offset:0];
}

+ (BOOL)stringMatchesFormat13:(NSString *)gtin {
    return [GTIN stringMatchesFormat:gtin format:GTINFormatGTIN_13 offset:0];
}

+ (BOOL)stringMatchesFormat14:(NSString *)gtin {
    return [GTIN stringMatchesFormat:gtin format:GTINFormatGTIN_14 offset:0];
}

+ (BOOL)stringMatchesFormat:(NSString *)gtin format:(GTINFormat)format offset:(NSUInteger)offset {
    if (gtin == nil) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"gtin is nil" userInfo:nil];
    }
    
    // Check length
    NSUInteger gtinLength = gtin.length;
    BOOL validLength = false;
    if (format != GTINFormatCount()) {
        validLength = gtinLength == GTINFormatLength(format);
    } else {
        for (id gtinFormatValue in GTINFormatValues()) {
            GTINFormat gtinFormat = (GTINFormat) [gtinFormatValue intValue];
            if (gtinLength == GTINFormatLength(gtinFormat) - offset) {
                validLength = true;
                break;
            }
        }
    }
    if (!validLength) {
        return false;
    }
    
    // Check whether is a number
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]+$"] evaluateWithObject:gtin];
}

- (GTINFormat)format {
    return _format;
}

- (NSUInteger)length {
    return GTINFormatLength(_format);
}

- (int)checkDigit {
    return [[_gtin substringFromIndex:_gtin.length - 1] intValue];
}

- (int)digitAtPosition:(NSUInteger)position {
    return [[_gtin substringWithRange:NSMakeRange(position, 1)] intValue];
}

- (NSString *)description {
    return _gtin;
}

- (BOOL)isEqual:(id)obj {
    return obj == self || ([obj isKindOfClass:[GTIN class]] && [((GTIN *) obj) isEqualToString:_gtin]);
}

- (BOOL)isEqualToGTIN:(GTIN *)gtin {
    return gtin == self || [gtin isEqualToString:_gtin];
}

- (BOOL)isEqualToString:(NSString *)gtin {
    return [_gtin isEqualToString:gtin];
}

- (NSUInteger)hash {
    return 37 + _gtin.hash;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_gtin forKey:kGtinKey];
}

#ifdef DEBUG
+ (void)load {
    [[NSUserDefaults standardUserDefaults] setValue:@"XCTestLog,GcovTestObserver"
                                             forKey:@"XCTestObserverClass"];
}
#endif

@end
