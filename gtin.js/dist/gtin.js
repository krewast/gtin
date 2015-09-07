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
 * Indicates an attempt to perform an operation on a string that is not a valid GTIN.
 */
function InvalidGTINError(message) {
    "use strict";
    var error = Error.apply(this, arguments);
    this.message = (message || null);
    this.name = error.name = "InvalidGTINError";
    if (error.stack) {
        this.stack = error.stack.substring(error.stack.indexOf("\n") + 1);
    }
    this.toString = function() {
        return (message !== null) ? (name + ": " + message) : name;
    };
}

// Inherit from Error
InvalidGTINError.prototype = Object.create(Error.prototype);
;/**
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
;/**
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
 * Valid GTIN code. Static methods are provided for identifying, validating and parsing GTIN codes
 * represented as strings.
 */
function GTIN(gtin) {
    "use strict";
    this.gtin = gtin;
    this.format = GTINFormat.forLength(gtin.length);
    this.length = this.format.length;

    /**
     * @return the check digit of this GTIN.
     */
    this.checkDigit = function() {
        return parseInt(this.gtin.substring(gtin.length - 1));
    };

    /**
     * Gets the digit at the specified position.
     *
     * @param position the position, from 0 to length - 1.
     * @return the digit at the specified position.
     * @throws java.lang.IndexOutOfBoundsException if the position is not between 0 and length - 1.
     */
    this.digitAt = function(position) {
        return parseInt(this.gtin.substring(position, position + 1));
    };

    /**
     * @return this GTIN code as a string.
     */
    this.toString = function() {
        return gtin;
    };

    this.equals = function(obj) {
        return obj === this || obj instanceof GTIN && gtin === obj.gtin;
    };

    this.hashCode = function() {
        var stringHashCode = function(str){
            var hash = 0;
            for (i = 0; i < str.length; i++) {
                char = str.charCodeAt(i);
                hash = ((hash << 5) - hash) + char;
                // Convert to 32bit integer
                hash = hash & hash;
            }
            return hash;
        };

        return 37 + stringHashCode(gtin);
    };
}

/**
 * Creates a GTIN from the given string.
 * You may use the {@link #isValid(String)} method first if you are unsure whether the
 * string is a valid GTIN to avoid.
 *
 * @param gtin the GTIN string.
 * @return a GTIN object if the string is a valid GTIN.
 * @throws InvalidGTINError if the string is not a valid GTIN.
 */

GTIN.create = function(gtin) {
    "use strict";
    if (!GTIN.isValid(gtin)) {
        throw new InvalidGTINError("String '" + gtin + "' is not a valid gtin");
    }
    var result = new GTIN(gtin);
    // Make sure length and format etc cannot be modified
    if (Object.freeze) {
        Object.freeze(result);
    }
    return result;
};

/**
 * Creates a GTIN from the given partial GTIN string without the check digit.
 *
 * @param gtinWithoutCheckDigit the GTIN without the final check digit.
 * @return a GTIN object if the string is a valid GTIN.
 * @throws InvalidGTINError if the string is not a valid partial GTIN.
 */
GTIN.createWithCheckDigit = function(gtinWithoutCheckDigit) {
    "use strict";
    return new GTIN(GTIN.withCheckDigit(gtinWithoutCheckDigit));
};

/**
 * Checks if the string is a valid format by checking the format, length
 * and checksum.
 *
 * @param gtin the GTIN string to check, may be GTIN-8, GTIN-12, GTIN-13 or GTIN-14 format.
 * @param format optional, the GTIN format to check the string against, if not specified accepts
 * any format.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
GTIN.isValid = function(gtin, format) {
    "use strict";
    // Check format of barcode for validity
    if (!GTIN.matchesFormat(gtin)) {
        return false;
    }
    var gtinLength = gtin.length;
    if (typeof format !== "undefined" && format !== null && gtinLength != format.length) {
        return false;
    }
    var checkSum = 0;
    var weightBit = gtinLength % 2;
    for (var i = 0; i < gtinLength; i++) {
        var weight = i % 2 == weightBit ? 3 : 1;
        checkSum += parseInt(gtin.substring(i, i + 1)) * weight;
    }
    return checkSum % 10 === 0;
};

/**
 * Checks if the string is a valid GTIN-8 by checking the format and checksum.
 *
 * @param gtin the GTIN-8 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
GTIN.isValid8 = function(gtin) {
    "use strict";
    return GTIN.isValid(gtin, GTINFormat.GTIN_8);
};

/**
 * Checks if the string is a valid GTIN-12 by checking the format and checksum.
 *
 * @param gtin the GTIN-12 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
GTIN.isValid12 = function(gtin) {
    "use strict";
    return GTIN.isValid(gtin, GTINFormat.GTIN_12);
};

/**
 * Checks if the string is a valid GTIN-13 by checking the format and checksum.
 *
 * @param gtin the GTIN-13 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
GTIN.isValid13 = function(gtin) {
    "use strict";
    return GTIN.isValid(gtin, GTINFormat.GTIN_13);
};

/**
 * Checks if the string is a valid GTIN-14 by checking the format and checksum.
 *
 * @param gtin the GTIN-14 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
GTIN.isValid14 = function(gtin) {
    "use strict";
    return GTIN.isValid(gtin, GTINFormat.GTIN_14);
};

/**
 * Calculates the check digit for a partial GTIN.
 *
 * @param gtinWithoutCheckDigit the GTIN without the final check digit.
 * @return the check digit to complete the GTIN code.
 * @throws InvalidGTINError if the string is not a valid partial GTIN without the check
 * digit.
 */
GTIN.calculateCheckDigit = function(gtinWithoutCheckDigit) {
    "use strict";
    if (!GTIN.matchesFormat(gtinWithoutCheckDigit, null, 1)) {
        throw new InvalidGTINError("String '" + gtinWithoutCheckDigit + "' is not a valid partial gtin");
    }
    var checkSum = 0;
    var gtinLength = gtinWithoutCheckDigit.length;
    var weightBit = (gtinLength + 1) % 2;
    for (var i = 0; i < gtinLength; i++) {
        var weight = i % 2 == weightBit ? 3 : 1;
        checkSum += parseInt(gtinWithoutCheckDigit.substring(i, i + 1)) * weight;
    }
    return checkSum % 10 === 0 ? 0 : 10 - (checkSum % 10);
};

/**
 * Returns the given partial GTIN code with check digit added.
 *
 * @param gtinWithoutCheckDigit the GTIN without the final check digit.
 * @return the GTIN code with check digit.
 * @throws InvalidGTINError if the string is not a valid partial GTIN without the check
 * digit.
 */
GTIN.withCheckDigit = function(gtinWithoutCheckDigit) {
    "use strict";
    return gtinWithoutCheckDigit + GTIN.calculateCheckDigit(gtinWithoutCheckDigit).toString();
};

/**
 * Checks whether the input string matches the specific GTIN format, i.e. is of the correct
 * length that format GTIN and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @param format optional, the GTIN format to check the string against.
 * @param offset optional, the number of characters missing from the full GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
// Private method
GTIN.matchesFormat = function(gtin, format, offset) {
    "use strict";
    if (typeof gtin === "undefined" ||gtin === null) {
        throw new Error("gtin is null");
    }
    if (typeof offset === "undefined" || offset === null) {
        offset = 0;
    }
    // Check length
    var gtinLength = gtin.length;
    var validLength = false;
    if (typeof format !== "undefined" && format !== null) {
        validLength = gtinLength == format.length;
    } else {
        var values = GTINFormat.values();
        for (var i in values) {
            var gtinFormat = values[i];
            if (gtinLength == gtinFormat.length - offset) {
                validLength = true;
                break;
            }
        }
    }
    if (!validLength) {
        return false;
    }
    // Check whether is a number
    return gtin.match(/^[0-9]+$/) !== null;
};

/**
 * Checks whether the input string matches the GTIN-8 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
GTIN.matchesFormat8 = function(gtin) {
    "use strict";
    return GTIN.matchesFormat(gtin, GTINFormat.GTIN_8, 0);
};

/**
 * Checks whether the input string matches the GTIN-12 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
GTIN.matchesFormat12 = function(gtin) {
    "use strict";
    return GTIN.matchesFormat(gtin, GTINFormat.GTIN_12, 0);
};

/**
 * Checks whether the input string matches the GTIN-13 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
GTIN.matchesFormat13 = function(gtin) {
    "use strict";
    return GTIN.matchesFormat(gtin, GTINFormat.GTIN_13, 0);
};

/**
 * Checks whether the input string matches the GTIN-14 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
GTIN.matchesFormat14 = function(gtin) {
    "use strict";
    return GTIN.matchesFormat(gtin, GTINFormat.GTIN_14, 0);
};
;/**
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

// Exports
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define([], factory);
    } else if (typeof module === 'object' && module.exports) {
        // Node. Does not work with strict CommonJS, but
        // only CommonJS-like environments that support module.exports,
        // like Node.
        module.exports = factory();
    } else {
        // Browser globals (root is window)
        root.returnExports = factory();
  }
}(this, function() {
    return {
        GTIN: GTIN,
        GTINFormat: GTINFormat,
        InvalidGTINError: InvalidGTINError
    };
}));
