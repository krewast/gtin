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

/**
 * Enumeration of the different Gtin formats.
 */
typedef NS_ENUM(NSInteger, GTINFormat) {
    /**
     * GTIN-8, EAN-8. The short version of EAN-13 for extremely small products.
     */
    GTINFormatGTIN_8,
    
    /**
     * GTIN-12, UPC-A, UPC-12. Standard version of the UPC code.
     */
    GTINFormatGTIN_12,
    
    /**
     * GTIN-13, EAN-13. Primarily used in supermarkets to identify products at the point of sales.
     */
    GTINFormatGTIN_13,
    
    /**
     * GTIN-14, EAN-14. Commonly used for traded goods.
     */
    GTINFormatGTIN_14
};

/**
 * @return the number of GTINFormats.
 */
NSUInteger GTINFormatCount();

/**
 * @return a set of all of the GTINFormats.
 */
NSOrderedSet *GTINFormatValues();

/**
 * Returns a description of the GTIN format.
 *
 * @param format the GTIN format.
 * @return the name of the format, e.g. GTIN-12 for GTINFormatGTIN_12.
 */
NSString *GTINFormatDescription(GTINFormat format);

/**
 * Returns the length of the GTIN format.
 *
 * @param format the GTIN format.
 * @return the length of the format, e.g. 12 for GTINFormatGTIN_12.
 */
NSUInteger GTINFormatLength(GTINFormat format);

/**
 * Gets the GTIN format for the specified enum constant name.
 *
 * @param name the name of the GTIN, e.g. GTINFormatGTIN_12.
 * @return the GTINFormat for the given name.
 * @throws NSRangeException if the name does not match the name of any of the
 * known formats.
 */
GTINFormat GTINFormatForName(NSString *name);

/**
 * Gets the GTIN format for the specified length.
 *
 * @param gtinLength the length of the GTIN.
 * @return the GTINFormat for the given length.
 * @throws NSRangeException if the length does not match the length of any of the
 * known formats.
 */
GTINFormat GTINFormatForLength(NSUInteger length);
