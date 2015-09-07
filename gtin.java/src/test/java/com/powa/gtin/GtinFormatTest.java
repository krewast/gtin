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

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class GtinFormatTest {

    @Test(expected = IllegalArgumentException.class)
    public void forLength7ShouldThrowException() {
        GtinFormat.forLength(7);
    }

    @Test
    public void forLength8ShouldReturnGtin8() {
        assertEquals(GtinFormat.GTIN_8, GtinFormat.forLength(8));
    }

    @Test(expected = IllegalArgumentException.class)
    public void forLength9ShouldThrowException() {
        GtinFormat.forLength(9);
    }

    @Test(expected = IllegalArgumentException.class)
    public void forLength11ShouldThrowException() {
        GtinFormat.forLength(11);
    }

    @Test
    public void forLength12ShouldReturnGtin12() {
        assertEquals(GtinFormat.GTIN_12, GtinFormat.forLength(12));
    }

    @Test
    public void forLength13ShouldReturnGtin13() {
        assertEquals(GtinFormat.GTIN_13, GtinFormat.forLength(13));
    }

    @Test
    public void forLength14ShouldReturnGtin14() {
        assertEquals(GtinFormat.GTIN_14, GtinFormat.forLength(14));
    }

    @Test(expected = IllegalArgumentException.class)
    public void forLength15ShouldThrowException() {
        GtinFormat.forLength(15);
    }

    @Test
    public void valueOf() {
        assertEquals(GtinFormat.GTIN_8, GtinFormat.valueOf("GTIN_8"));
        assertEquals(GtinFormat.GTIN_12, GtinFormat.valueOf("GTIN_12"));
        assertEquals(GtinFormat.GTIN_13, GtinFormat.valueOf("GTIN_13"));
        assertEquals(GtinFormat.GTIN_14, GtinFormat.valueOf("GTIN_14"));
    }

    @Test(expected = IllegalArgumentException.class)
    public void valueOfUnknownValueShouldThrowException() {
        GtinFormat.valueOf("GTIN_15");
    }

    @Test
    public void toStringShouldReturnReadableNames() {
        assertEquals("GTIN-8", GtinFormat.GTIN_8.toString());
        assertEquals("GTIN-12", GtinFormat.GTIN_12.toString());
        assertEquals("GTIN-13", GtinFormat.GTIN_13.toString());
        assertEquals("GTIN-14", GtinFormat.GTIN_14.toString());
    }

}
