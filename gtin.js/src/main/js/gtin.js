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
 * Valid GTIN code. Static methods are provided for identifying, validating and parsing GTIN codes
 * represented as strings.
 */
function Gtin(gtin) {
    "use strict";
    this.gtin = gtin;
    this.format = GtinFormat.forLength(gtin.length);
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

    this.equals = function(other) {
        return other === this || other instanceof Gtin && gtin === other.gtin;
    };

    this.hashCode = function() {
        var stringHashCode = function(str){
            var hash = 0;
            for (i = 0; i < str.length; i++) {
                var char = str.charCodeAt(i);
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
 * string is a valid GTIN to avoid a GtinFormatError being thrown.
 *
 * @param gtin the GTIN string.
 * @return a Gtin object if the string is a valid GTIN.
 * @throws GtinFormatError if the string is not a valid GTIN.
 */

Gtin.create = function(gtin) {
    "use strict";
    if (!Gtin.isValid(gtin)) {
        throw new GtinFormatError("String '" + gtin + "' is not a valid gtin");
    }
    var result = new Gtin(gtin);
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
 * @return a GTIN object if the string is a valid GITN.
 * @throws GtinFormatError if the string is not a valid partial GTIN.
 */
Gtin.createWithCheckDigit = function(gtinWithoutCheckDigit) {
    "use strict";
    return new Gtin(Gtin.withCheckDigit(gtinWithoutCheckDigit));
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
Gtin.isValid = function(gtin, format) {
    "use strict";
    // Check format of barcode for validity
    if (!Gtin.matchesFormat(gtin)) {
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
Gtin.isValid8 = function(gtin) {
    "use strict";
    return Gtin.isValid(gtin, GtinFormat.GTIN_8);
};

/**
 * Checks if the string is a valid GTIN-12 by checking the format and checksum.
 *
 * @param gtin the GTIN-12 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
Gtin.isValid12 = function(gtin) {
    "use strict";
    return Gtin.isValid(gtin, GtinFormat.GTIN_12);
};

/**
 * Checks if the string is a valid GTIN-13 by checking the format and checksum.
 *
 * @param gtin the GTIN-13 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
Gtin.isValid13 = function(gtin) {
    "use strict";
    return Gtin.isValid(gtin, GtinFormat.GTIN_13);
};

/**
 * Checks if the string is a valid GTIN-14 by checking the format and checksum.
 *
 * @param gtin the GTIN-14 string to check.
 * @return {@code true} if the GTIN is valid, {@code false} otherwise.
 */
Gtin.isValid14 = function(gtin) {
    "use strict";
    return Gtin.isValid(gtin, GtinFormat.GTIN_14);
};

/**
 * Calculates the check digit for a partial GTIN.
 *
 * @param gtinWithoutCheckDigit the GTIN without the final check digit.
 * @return the check digit to complete the GTIN code.
 * @throws GtinFormatError if the string is not a valid partial GTIN without the check
 * digit.
 */
Gtin.calculateCheckDigit = function(gtinWithoutCheckDigit) {
    "use strict";
    if (!Gtin.matchesFormat(gtinWithoutCheckDigit, null, 1)) {
        throw new GtinFormatError("String '" + gtinWithoutCheckDigit + "' is not a valid partial gtin");
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
 * @throws GtinFormatError if the string is not a valid partial GTIN without the check
 * digit.
 */
Gtin.withCheckDigit = function(gtinWithoutCheckDigit) {
    "use strict";
    return gtinWithoutCheckDigit + Gtin.calculateCheckDigit(gtinWithoutCheckDigit).toString();
};

/**
 * Checks whether the input string matches the GTIN format, i.e. is of the correct
 * length that format Gtin and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @param format optional, the GTIN format to check the string against.
 * @param offset optional, the number of characters missing from the full GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
// Private method
Gtin.matchesFormat = function(gtin, format, offset) {
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
        var values = GtinFormat.values();
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
Gtin.matchesFormat8 = function(gtin) {
    "use strict";
    return Gtin.matchesFormat(gtin, GtinFormat.GTIN_8, 0);
};

/**
 * Checks whether the input string matches the GTIN-12 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
Gtin.matchesFormat12 = function(gtin) {
    "use strict";
    return Gtin.matchesFormat(gtin, GtinFormat.GTIN_12, 0);
};

/**
 * Checks whether the input string matches the GTIN-13 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
Gtin.matchesFormat13 = function(gtin) {
    "use strict";
    return Gtin.matchesFormat(gtin, GtinFormat.GTIN_13, 0);
};

/**
 * Checks whether the input string matches the GTIN-14 format, i.e. is of the correct
 * length and that the string contains only digits.
 *
 * @param gtin the possible GTIN string.
 * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
 */
Gtin.matchesFormat14 = function(gtin) {
    "use strict";
    return Gtin.matchesFormat(gtin, GtinFormat.GTIN_14, 0);
};
