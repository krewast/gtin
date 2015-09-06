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

import java.io.Serializable;

/**
 * Valid GTIN code. Static methods are provided for identifying, validating and parsing GTIN codes
 * represented as strings.
 */
public final class GTIN implements Serializable {

    private static final long serialVersionUID = 349852370955535L;

    private final String gtin;
    private final GTINFormat format;

    // Prevent instantiation
    private GTIN(final String gtin) {
        this.gtin = gtin;
        format = GTINFormat.forLength(gtin.length());
    }

    /**
     * Creates a GTIN from the given string.
     * You may use the {@link #isValid(String)} method first if you are unsure whether the
     * string is a valid GTIN to avoid.
     *
     * @param gtin the GTIN string.
     * @return a GTIN object if the string is a valid GTIN.
     * @throws InvalidGTINException if the string is not a valid GTIN.
     */
    public static GTIN create(final String gtin) throws InvalidGTINException {
        if (!isValid(gtin)) {
            throw new InvalidGTINException("String '" + gtin + "' is not a valid gtin");
        }

        return new GTIN(gtin);
    }

    /**
     * Creates a GTIN from the given partial GTIN string without the check digit.
     *
     * @param gtinWithoutCheckDigit the GTIN without the final check digit.
     * @return a GTIN object if the string is a valid GTIN.
     * @throws InvalidGTINException if the string is not a valid partial GTIN.
     */
    public static GTIN createWithCheckDigit(final String gtinWithoutCheckDigit) throws InvalidGTINException {
        return new GTIN(withCheckDigit(gtinWithoutCheckDigit));
    }

    /**
     * Checks if the string is a valid GTIN by checking the format and checksum.
     *
     * @param gtin the GTIN string to check, may be GTIN-8, GTIN-12, GTIN-13 or GTIN-14 format.
     * @return {@code true} if the GTIN is valid, {@code false} otherwise.
     */
    public static boolean isValid(final String gtin) {
        return isValid(gtin, null);
    }

    /**
     * Checks if the string is a valid specific GTIN format by checking the format, length
     * and checksum.
     *
     * @param gtin the GTIN string to check, may be GTIN-8, GTIN-12, GTIN-13 or GTIN-14 format.
     * @param format the GTIN format to check the string against.
     * @return {@code true} if the GTIN is valid, {@code false} otherwise.
     */
    public static boolean isValid(final String gtin, final GTINFormat format) {
        // Check format of barcode for validity
        if (!matchesFormat(gtin)) {
            return false;
        }
        if (format != null && gtin.length() != format.length()) {
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
     * Checks if the string is a valid GTIN-8 by checking the format and checksum.
     *
     * @param gtin the GTIN-8 string to check.
     * @return {@code true} if the GTIN is valid, {@code false} otherwise.
     */
    public static boolean isValid8(final String gtin) {
        return isValid(gtin, GTINFormat.GTIN_8);
    }

    /**
     * Checks if the string is a valid GTIN-12 by checking the format and checksum.
     *
     * @param gtin the GTIN-12 string to check.
     * @return {@code true} if the GTIN is valid, {@code false} otherwise.
     */
    public static boolean isValid12(final String gtin) {
        return isValid(gtin, GTINFormat.GTIN_12);
    }

    /**
     * Checks if the string is a valid GTIN-13 by checking the format and checksum.
     *
     * @param gtin the GTIN-13 string to check.
     * @return {@code true} if the GTIN is valid, {@code false} otherwise.
     */
    public static boolean isValid13(final String gtin) {
        return isValid(gtin, GTINFormat.GTIN_13);
    }

    /**
     * Checks if the string is a valid GTIN-14 by checking the format and checksum.
     *
     * @param gtin the GTIN-14 string to check.
     * @return {@code true} if the GTIN is valid, {@code false} otherwise.
     */
    public static boolean isValid14(final String gtin) {
        return isValid(gtin, GTINFormat.GTIN_14);
    }

    /**
     * Calculates the check digit for a partial GTIN.
     *
     * @param gtinWithoutCheckDigit the GTIN without the final check digit.
     * @return the check digit to complete the GTIN code.
     * @throws InvalidGTINException if the string is not a valid partial GTIN without the check
     * digit.
     */
    public static int calculateCheckDigit(final String gtinWithoutCheckDigit) {
        if (!matchesFormat(gtinWithoutCheckDigit, 1)) {
            throw new InvalidGTINException("String '" + gtinWithoutCheckDigit + "' is not a valid partial gtin");
        }
        int checkSum = 0;
        int gtinLength = gtinWithoutCheckDigit.length();
        int weightBit = (gtinLength + 1) % 2;
        for (int i = 0; i < gtinLength; i++) {
            int weight = i % 2 == weightBit ? 3 : 1;
            checkSum += Integer.parseInt(gtinWithoutCheckDigit.substring(i, i + 1)) * weight;
        }
        return checkSum % 10 == 0 ? 0 : 10 - (checkSum % 10);
    }

    /**
     * Returns the given partial GTIN code with check digit added.
     *
     * @param gtinWithoutCheckDigit the GTIN without the final check digit.
     * @return the GTIN code with check digit.
     * @throws InvalidGTINException if the string is not a valid partial GTIN without the check
     * digit.
     */
    public static String withCheckDigit(final String gtinWithoutCheckDigit) {
        return gtinWithoutCheckDigit + Integer.toString(calculateCheckDigit(gtinWithoutCheckDigit));
    }

    /**
     * Checks whether the input string matches the GTIN format, i.e. is of the correct length for
     * a GTIN and that the string contains only digits.
     *
     * @param gtin the possible GTIN string.
     * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
     */
    public static boolean matchesFormat(final String gtin) {
        return matchesFormat(gtin, 0);
    }

    private static boolean matchesFormat(final String gtin, final int offset) {
        if (gtin == null) {
            throw new IllegalArgumentException("gtin is null");
        }
        // Check length
        int gtinLength = gtin.length();
        boolean validLength = false;
        for (GTINFormat gtinFormat : GTINFormat.values()) {
            if (gtinLength == gtinFormat.length() - offset) {
                validLength = true;
                break;
            }
        }
        if (!validLength) {
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
     * @return the check digit of this GTIN.
     */
    public int checkDigit() {
        return Integer.parseInt(gtin.substring(gtin.length() - 1));
    }

    /**
     * Gets the digit at the specified position.
     *
     * @param position the position, from 0 to length - 1.
     * @return the digit at the specified position.
     * @throws java.lang.IndexOutOfBoundsException if the position is not between 0 and length - 1.
     */
    public int digitAt(final int position) {
        return Integer.parseInt(gtin.substring(position, position + 1));
    }

    /**
     * @return this GTIN code as a string.
     */
    @Override
    public String toString() {
        return gtin;
    }

    @Override
    public boolean equals(final Object obj) {
        return obj == this || obj instanceof GTIN && gtin.equals(((GTIN) obj).gtin);
    }

    @Override
    public int hashCode() {
        return 37 + gtin.hashCode();
    }

}
