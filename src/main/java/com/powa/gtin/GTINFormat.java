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
 * Enumeration of the different GTIN formats.
 */
public enum GTINFormat {

    /**
     * GTIN-8, EAN-8. The short version of EAN-13 for extremely small products.
     */
    GTIN_8(8),

    /**
     * GTIN-12, UPC-A, UPC-12. Standard version of the UPC code.
     */
    GTIN_12(12),

    /**
     * GTIN-13, EAN-13. Primarily used in supermarkets to identify products at the point of sales.
     */
    GTIN_13(13),

    /**
     * GTIN-14, EAN-14. Commonly used for traded goods.
     */
    GTIN_14(14);

    private final int length;

    GTINFormat(final int length) {
        this.length = length;
    }

    static GTINFormat forLength(final int gtinLength) {
        GTINFormat[] gtinFormats = GTINFormat.values();
        for (GTINFormat gtinFormat : gtinFormats) {
            if (gtinLength == gtinFormat.length()) {
                return gtinFormat;
            }
        }

        throw new IllegalArgumentException(String.format("Length '%d' does not match the length"
                + " of any known GTIN formats", gtinLength));
    }

    /**
     * @return The length of this GTIN format.
     */
    public int length() {
        return length;
    }

}
