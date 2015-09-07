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

/**
 * Enumeration of the different GTIN formats.
 */
function GTINFormat(length) {
    "use strict";
    this.length = length;
    /**
     * @return the name of the format, e.g. GTIN-12.
     */
    this.toString = function() {
        return "GTIN-" + length.toString();
    };
}

/**
 * GTIN-8, EAN-8. The short version of EAN-13 for extremely small products.
 */
GTINFormat.GTIN_8 = new GTINFormat(8);

/**
 * GTIN-12, UPC-A, UPC-12. Standard version of the UPC code.
 */
GTINFormat.GTIN_12 = new GTINFormat(12);

/**
 * GTIN-13, EAN-13. Primarily used in supermarkets to identify products at the point of sales.
 */
GTINFormat.GTIN_13 = new GTINFormat(13);

/**
 * GTIN-14, EAN-14. Commonly used for traded goods.
 */
GTINFormat.GTIN_14 = new GTINFormat(14);

/**
 * @return an array of all of the GTINFormats.
 */
GTINFormat.values = function() {
    "use strict";
    return {
        GTIN_8: GTINFormat.GTIN_8,
        GTIN_12: GTINFormat.GTIN_12,
        GTIN_13: GTINFormat.GTIN_13,
        GTIN_14: GTINFormat.GTIN_14
    };
};

/**
 * Returns the enum constant of the specified enum type with the specified name.
 *
 * @param the name of the constant to return.
 * @return the enum constant of the specified enum type with the specified name.
 */
GTINFormat.valueOf = function(name) {
    var values = GTINFormat.values();
    for (var i in values) {
        if (i == name) {
            return values[i];
        }
    }
    throw new RangeError("Name '" + name + "' does not match the " +
                "name of any known GTIN formats");
};

/**
 * Gets the GTIN format for the specified length.
 *
 * @param gtinLength the length of the GTIN.
 * @return the GTINFormat for the given length.
 * @throws RangeError if the length does not match the length of any of the
 * known formats.
 */
GTINFormat.forLength = function(gtinLength) {
    "use strict";
    var values = GTINFormat.values();
    for (var i in values) {
        var gtinFormat = values[i];
        if (gtinLength == gtinFormat.length) {
            return gtinFormat;
        }
    }
    throw new RangeError("Length '" + gtinLength + "' does not match the " +
            "length of any known GTIN formats");
};

// Freeze the GTINFormat object and values so they cannot be modified.
if (Object.freeze) {
    Object.freeze(GTINFormat);
    var values = GTINFormat.values();
    for (var i in values) {
        var gtinFormat = values[i];
        Object.freeze(gtinFormat);
    }
}
