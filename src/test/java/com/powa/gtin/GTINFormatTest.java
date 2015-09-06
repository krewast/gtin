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

public class GTINFormatTest {

    @Test(expected = IllegalArgumentException.class)
    public void formatForLength7ShouldThrowIllegalArgumentException() {
        GTINFormat.forLength(7);
    }

    @Test
    public void formatForLength8ShouldReturnGTIN_8() {
        assertEquals(GTINFormat.GTIN_8, GTINFormat.forLength(8));
    }

    @Test(expected = IllegalArgumentException.class)
    public void formatForLength9ShouldThrowIllegalArgumentException() {
        GTINFormat.forLength(9);
    }

    @Test(expected = IllegalArgumentException.class)
    public void formatForLength11ShouldThrowIllegalArgumentException() {
        GTINFormat.forLength(11);
    }

    @Test
    public void formatForLength12ShouldReturnGTIN_12() {
        assertEquals(GTINFormat.GTIN_12, GTINFormat.forLength(12));
    }

    @Test
    public void formatForLength13ShouldReturnGTIN_13() {
        assertEquals(GTINFormat.GTIN_13, GTINFormat.forLength(13));
    }

    @Test
    public void formatForLength14ShouldReturnGTIN_14() {
        assertEquals(GTINFormat.GTIN_14, GTINFormat.forLength(14));
    }

    @Test(expected = IllegalArgumentException.class)
    public void formatForLength15ShouldThrowIllegalArgumentException() {
        GTINFormat.forLength(15);
    }

}
