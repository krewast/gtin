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
package com.powa.gtin;

/**
 * Valid GTIN code. Static methods are provided for identifying, validating and parsing GTIN codes
 * represented as strings.
 */
public final class GTIN {

    private final String gtin;
    private final GTINFormat format;

    // Prevent instantiation
    private GTIN(final String gtin) {
        this.gtin = gtin;
        format = GTINFormat.forLength(gtin.length());
    }

    /**
     * Parses a GTIN string into a GTIN object.
     * You may use the {@link #isValid(String)} method first if you are unsure whether the
     * string is a valid GTIN to avoid.
     *
     * @param gtin the GTIN string.
     * @return a GTIN object if the string is a valid GTIN.
     * @throws InvalidGTINException if the string is not a valid GTIN.
     */
    public static GTIN parse(final String gtin) throws InvalidGTINException {
        if (!isValid(gtin)) {
            throw new InvalidGTINException("Cannot parse invalid string " + gtin + " to string");
        }

        return new GTIN(gtin);
    }

    /**
     * Checks the GTIN for validity by checking the format and checksum.
     *
     * @param gtin the GTIN, may be GTIN-8, GTIN-12, GTIN-13 or GTIN-14 format.
     * @return {@code true} if the GTIN is valid, {@code false} otherwise.
     */
    public static boolean isValid(final String gtin) {
        // Check format of barcode for validity
        if (!matchesFormat(gtin)) {
            return false;
        }

        int checkSum = 0;
        int gtinLength = gtin.length();
        int weightBit = gtinLength % 2;
        for (int i = 0; i < gtinLength; i++) {
            int weight = i % 2 == weightBit ? 3 : 1;
            checkSum += Integer.parseInt(gtin.substring(i, i + 1)) * weight;
        }

        return checkSum % 10 == 0;
    }

    /**
     * Checks whether the input string matches the GTIN format, i.e. is of the correct length for
     * a GTIN and that the string contains only digits.
     *
     * @param gtin the possible GTIN string.
     * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
     */
    public static boolean matchesFormat(final String gtin) {
        if (gtin == null) {
            throw new IllegalArgumentException("gtin is null");
        }

        // Check length is ok
        int gtinLength = gtin.length();
        if (gtinLength != 8 && gtinLength != 12 && gtinLength != 13 && gtinLength != 14) {
            return false;
        }

        // Check whether is a number
        return gtin.matches("^\\d+$");
    }

    /**
     * @return the format or type of this GTIN.
     */
    public GTINFormat format() {
        return format;
    }

    /**
     * @return the length of this GTIN.
     */
    public int length() {
        return format.length();
    }

    /**
     * @return this GTIN code as a string.
     */
    @Override
    public String toString() {
        return gtin;
    }

}
