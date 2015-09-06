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

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

public class GTINTest {

    @Test
    public void stringOf7DigitsShouldNotMatchFormat() {
        String digits7 = "0123456";

        assertFalse(GTIN.matchesFormat(digits7));
    }

    @Test
    public void stringOf8DigitsShouldMatchFormat() {
        String digits8 = "01234567";

        assertTrue(GTIN.matchesFormat(digits8));
    }

    @Test
    public void stringOf8LettersShouldNotMatchFormat() {
        String letters8 = "abcdefgh";

        assertFalse(GTIN.matchesFormat(letters8));
    }

    @Test
    public void stringOf8LettersAndDigitsShouldNotMatchFormat() {
        String lettersAndDigits8 = "0a1b2c3d";

        assertFalse(GTIN.matchesFormat(lettersAndDigits8));
    }

    @Test
    public void stringOf9DigitsShouldNotMatchFormat() {
        String digits9 = "012345678";

        assertFalse(GTIN.matchesFormat(digits9));
    }

    @Test
    public void stringOf11DigitsShouldNotMatchFormat() {
        String digits11 = "01234567890";

        assertFalse(GTIN.matchesFormat(digits11));
    }

    @Test
    public void stringOf12DigitsShouldMatchFormat() {
        String digits12 = "012345678901";

        assertTrue(GTIN.matchesFormat(digits12));
    }

    @Test
    public void stringOf12LettersShouldNotMatchFormat() {
        String letters12 = "abcdefghijkl";

        assertFalse(GTIN.matchesFormat(letters12));
    }

    @Test
    public void stringOf12LettersAndDigitsShouldNotMatchFormat() {
        String lettersAndDigits12 = "0a1b2c3d4e5f6g";

        assertFalse(GTIN.matchesFormat(lettersAndDigits12));
    }

    @Test
    public void stringOf13DigitsShouldMatchFormat() {
        String digits13 = "0123456789012";

        assertTrue(GTIN.matchesFormat(digits13));
    }

    @Test
    public void stringOf13LettersShouldNotMatchFormat() {
        String letters13 = "abcdefghijklm";

        assertFalse(GTIN.matchesFormat(letters13));
    }

    @Test
    public void stringOf13LettersAndDigitsShouldNotMatchFormat() {
        String lettersAndDigits13 = "0a1b2c3d4e5f6g7";

        assertFalse(GTIN.matchesFormat(lettersAndDigits13));
    }

    @Test
    public void stringOf14DigitsShouldMatchFormat() {
        String digits14 = "01234567890123";

        assertTrue(GTIN.matchesFormat(digits14));
    }

    @Test
    public void stringOf14LettersShouldNotMatchFormat() {
        String letters14 = "abcdefghijklmn";

        assertFalse(GTIN.matchesFormat(letters14));
    }

    @Test
    public void stringOf14LettersAndDigitsShouldNotMatchFormat() {
        String lettersAndDigits14 = "0a1b2c3d4e5f6g7h";

        assertFalse(GTIN.matchesFormat(lettersAndDigits14));
    }

    @Test
    public void stringOf15DigitsShouldNotMatchFormat() {
        String digits15 = "012345678901234";

        assertFalse(GTIN.matchesFormat(digits15));
    }

    @Test
    public void gtin8ShouldBeValid() {
        String gtin8 = "73513537";

        assertTrue(GTIN.isValid(gtin8));
    }

    @Test
    public void gtin8ShouldBeValid2() {
        String gtin8 = "03485736";

        assertTrue(GTIN.isValid(gtin8));
    }

    @Test
    public void gtin8ShouldParseToGTIN() {
        String gtin8 = "03485736";

        GTIN gtin = GTIN.parse(gtin8);

        assertEquals(GTINFormat.GTIN_8, gtin.format());
        assertEquals(8, gtin.length());
        assertEquals(gtin8, gtin.toString());
    }

    @Test
    public void gtin8WithInvalidCheckDigitShouldNotBeValid() {
        String badGtin8 = "73513536";

        assertFalse(GTIN.isValid(badGtin8));
    }

    @Test(expected = InvalidGTINException.class)
    public void gtin8WithInvalidCheckDigitShouldNotParseToGTIN() {
        String badGtin8 = "73513536";

        GTIN.parse(badGtin8);
    }

    @Test
    public void gtin12ShouldBeValid() {
        String gtin12 = "123456789012";

        assertTrue(GTIN.isValid(gtin12));
    }

    @Test
    public void gtin12ShouldBeValid2() {
        String gtin12 = "734092309436";

        assertTrue(GTIN.isValid(gtin12));
    }

    @Test
    public void gtin12ShouldParseToGTIN() {
        String gtin12 = "734092309436";

        GTIN gtin = GTIN.parse(gtin12);

        assertEquals(GTINFormat.GTIN_12, gtin.format());
        assertEquals(12, gtin.length());
        assertEquals(gtin12, gtin.toString());
    }

    @Test
    public void gtin12WithInvalidCheckDigitShouldNotBeValid() {
        String badGtin12 = "123456789010";

        assertFalse(GTIN.isValid(badGtin12));
    }

    @Test(expected = InvalidGTINException.class)
    public void gtin12WithInvalidCheckDigitShouldNotParseToGTIN() {
        String badGtin12 = "123456789010";

        GTIN.parse(badGtin12);
    }

    @Test
    public void gtin13ShouldBeValid() {
        String gtin13 = "4006381333931";

        assertTrue(GTIN.isValid(gtin13));
    }

    @Test
    public void gtin13ShouldBeValid2() {
        String gtin13 = "0234248273487";

        assertTrue(GTIN.isValid(gtin13));
    }

    @Test
    public void gtin13ShouldParseToGTIN() {
        String gtin13 = "0234248273487";

        GTIN gtin = GTIN.parse(gtin13);

        assertEquals(GTINFormat.GTIN_13, gtin.format());
        assertEquals(13, gtin.length());
        assertEquals(gtin13, gtin.toString());
    }

    @Test
    public void gtin13WithInvalidCheckDigitShouldNotBeValid() {
        String badGtin13 = "4006381333932";

        assertFalse(GTIN.isValid(badGtin13));
    }

    @Test(expected = InvalidGTINException.class)
    public void gtin13WithInvalidCheckDigitShouldNotParseToGTIN() {
        String badGtin13 = "4006381333932";

        GTIN.parse(badGtin13);
    }

    @Test
    public void gtin14ShouldBeValid() {
        String gtin14 = "10614141000415";

        assertTrue(GTIN.isValid(gtin14));
    }

    @Test
    public void gtin14ShouldBeValid2() {
        String gtin14 = "34957354738950";

        assertTrue(GTIN.isValid(gtin14));
    }

    @Test
    public void gtin14ShouldParseToGTIN() {
        String gtin14 = "10614141000415";

        GTIN gtin = GTIN.parse(gtin14);

        assertEquals(GTINFormat.GTIN_14, gtin.format());
        assertEquals(14, gtin.length());
        assertEquals(gtin14, gtin.toString());
    }

    @Test
    public void gtin14WithInvalidCheckDigitShouldNotBeValid() {
        String badGtin14 = "10614141000416";

        assertFalse(GTIN.isValid(badGtin14));
    }

    @Test(expected = InvalidGTINException.class)
    public void gtin14WithInvalidCheckDigitShouldNotParseToGTIN() {
        String badGtin14 = "10614141000416";

        GTIN.parse(badGtin14);
    }

    @Test
    public void gtinsShouldBeEqual() throws Exception {
        String gtin14 = "10614141000415";
        GTIN gtin1 = GTIN.parse(gtin14);
        GTIN gtin2 = GTIN.parse(gtin14);

        assertTrue(gtin1.equals(gtin2));
    }

    @Test
    public void gtinAndDeserializedGtinShouldBeEqual() throws Exception {
        String gtin14 = "10614141000415";

        GTIN gtin = GTIN.parse(gtin14);
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        ObjectOutputStream oos = new ObjectOutputStream(buffer);
        oos.writeObject(gtin);
        oos.flush();
        oos.close();
        ByteArrayInputStream in = new ByteArrayInputStream(buffer.toByteArray());
        ObjectInputStream ois = new ObjectInputStream(in);
        GTIN deserializedGtin = (GTIN) ois.readObject();

        assertEquals(gtin, deserializedGtin);
        assertEquals(gtin.toString(), deserializedGtin.toString());
        assertEquals(gtin.format(), deserializedGtin.format());
        assertEquals(gtin.length(), deserializedGtin.length());
    }

}