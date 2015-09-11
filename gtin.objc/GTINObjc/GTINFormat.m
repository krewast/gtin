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

#import "GTINFormat.h"

static NSString* GTINFormatNames[] = {
    @"GTINFormatGTIN_8", @"GTINFormatGTIN_12", @"GTINFormatGTIN_13", @"GTINFormatGTIN_14"
};

static NSString* GTINFormatDescriptions[] = {
    @"GTIN-8", @"GTIN-12", @"GTIN-13", @"GTIN-14"
};

static NSUInteger GTINFormatLengths[] = {
    8, 12, 13, 14
};

NSUInteger GTINFormatCount() {
    return GTINFormatValues().count;
}

NSOrderedSet *GTINFormatValues() {
    static NSOrderedSet *valueSet = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        valueSet = [[NSOrderedSet alloc] initWithObjects:
                    [NSNumber numberWithInt:GTINFormatGTIN_8], [NSNumber numberWithInt:GTINFormatGTIN_12],
                    [NSNumber numberWithInt:GTINFormatGTIN_13], [NSNumber numberWithInt:GTINFormatGTIN_14],
                    nil];
        NSLog(@"GTINFormatValues:%@", valueSet);
    });
    
    return valueSet;
}

NSString *GTINFormatDescription(GTINFormat format) {
    return GTINFormatDescriptions[format];
}

NSUInteger GTINFormatLength(GTINFormat format) {
    return GTINFormatLengths[format];
}

GTINFormat GTINFormatForName(NSString *name) {
    for (int i = 0; i < GTINFormatCount(); i++) {
        if ([name isEqualToString:GTINFormatNames[i]]) {
            return (GTINFormat) i;
        }
    }
    @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:@"Name %@ does not match the name of any known GTIN formats", name] userInfo:nil];
}

GTINFormat GTINFormatForLength(NSUInteger length) {
    for (int i = 0; i < GTINFormatCount(); i++) {
        if (length == GTINFormatLength(i)) {
            return (GTINFormat) i;
        }
    }
    @throw [NSException exceptionWithName:NSRangeException reason:[NSString stringWithFormat:@"Length %lu does not match the length of any known GTIN formats", (unsigned long) length] userInfo:nil];
}
