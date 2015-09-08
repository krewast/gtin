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
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertTrue;

public class GtinTest {

    @Test
    public void stringOf7DigitsShouldNotBeValid() {
        String digits7 = "0123456";

        assertFalse(Gtin.isValid(digits7));
    }

    @Test
    public void gtin8ShouldBeValid() {
        String gtin8 = "73513537";

        assertTrue(Gtin.isValid(gtin8));
    }

    @Test
    public void stringOf8LettersShouldNotBeValid() {
        String letters8 = "abcdefgh";

        assertFalse(Gtin.isValid(letters8));
    }

    @Test
    public void gtin8WithInvalidCheckDigitShouldNotBeValid() {
        String badGtin8 = "73513536";

        assertFalse(Gtin.isValid(badGtin8));
    }

    @Test
    public void gtin12ShouldBeValid() {
        String gtin12 = "123456789012";

        assertTrue(Gtin.isValid(gtin12));
    }

    @Test
    public void gtin12WithInvalidCheckDigitShouldNotBeValid() {
        String badGtin12 = "123456789010";

        assertFalse(Gtin.isValid(badGtin12));
    }

    @Test
    public void gtin13ShouldBeValid() {
        String gtin13 = "4006381333931";

        assertTrue(Gtin.isValid(gtin13));
    }

    @Test
    public void gtin13WithInvalidCheckDigitShouldNotBeValid() {
        String badGtin13 = "4006381333932";

        assertFalse(Gtin.isValid(badGtin13));
    }

    @Test
    public void gtin14ShouldBeValid() {
        String gtin14 = "10614141000415";

        assertTrue(Gtin.isValid(gtin14));
    }

    @Test
    public void gtin14WithInvalidCheckDigitShouldNotBeValid() {
        String badGtin14 = "10614141000416";

        assertFalse(Gtin.isValid(badGtin14));
    }

    @Test(expected = IllegalArgumentException.class)
    public void validateNullShouldThrowException() {
        Gtin.isValid(null);
    }

    @Test
    public void gtin8ShouldBeValid8() {
        String gtin8 = "03485736";

        assertTrue(Gtin.isValid8(gtin8));
    }

    @Test
    public void gtin14ShouldNotBeValid8() {
        String gtin14 = "34957354738950";

        assertFalse(Gtin.isValid8(gtin14));
    }

    @Test
    public void gtin12ShouldBeValid12() {
        String gtin12 = "734092309436";

        assertTrue(Gtin.isValid12(gtin12));
    }

    @Test
    public void gtin13ShouldBeValid13() {
        String gtin13 = "0234248273487";

        assertTrue(Gtin.isValid13(gtin13));
    }

    @Test
    public void gtin14ShouldBeValid14() {
        String gtin14 = "34957354738950";

        assertTrue(Gtin.isValid14(gtin14));
    }

    @Test
    public void gtin13ShouldNotBeValid14() {
        String gtin13 = "0234248273487";

        assertFalse(Gtin.isValid14(gtin13));
    }

    @Test
    public void stringOf7DigitsShouldNotMatchFormat() {
        String digits7 = "0123456";

        assertFalse(Gtin.matchesFormat(digits7));
    }

    @Test
    public void stringOf8DigitsShouldMatchFormat() {
        String digits8 = "01234567";

        assertTrue(Gtin.matchesFormat(digits8));
    }

    @Test
    public void stringOf8LettersShouldNotMatchFormat() {
        String letters8 = "abcdefgh";

        assertFalse(Gtin.matchesFormat(letters8));
    }

    @Test
    public void stringOf8LettersAndDigitsShouldNotMatchFormat() {
        String lettersAndDigits8 = "0a1b2c3d";

        assertFalse(Gtin.matchesFormat(lettersAndDigits8));
    }

    @Test
    public void stringOf9DigitsShouldNotMatchFormat() {
        String digits9 = "012345678";

        assertFalse(Gtin.matchesFormat(digits9));
    }

    @Test
    public void stringOf11DigitsShouldNotMatchFormat() {
        String digits11 = "01234567890";

        assertFalse(Gtin.matchesFormat(digits11));
    }

    @Test
    public void stringOf12DigitsShouldMatchFormat() {
        String digits12 = "012345678901";

        assertTrue(Gtin.matchesFormat(digits12));
    }

    @Test
    public void stringOf12LettersShouldNotMatchFormat() {
        String letters12 = "abcdefghijkl";

        assertFalse(Gtin.matchesFormat(letters12));
    }

    @Test
    public void stringOf12LettersAndDigitsShouldNotMatchFormat() {
        String lettersAndDigits12 = "0a1b2c3d4e5f6g";

        assertFalse(Gtin.matchesFormat(lettersAndDigits12));
    }

    @Test
    public void stringOf13DigitsShouldMatchFormat() {
        String digits13 = "0123456789012";

        assertTrue(Gtin.matchesFormat(digits13));
    }

    @Test
    public void stringOf13LettersShouldNotMatchFormat() {
        String letters13 = "abcdefghijklm";

        assertFalse(Gtin.matchesFormat(letters13));
    }

    @Test
    public void stringOf13LettersAndDigitsShouldNotMatchFormat() {
        String lettersAndDigits13 = "0a1b2c3d4e5f6g7";

        assertFalse(Gtin.matchesFormat(lettersAndDigits13));
    }

    @Test
    public void stringOf14DigitsShouldMatchFormat() {
        String digits14 = "01234567890123";

        assertTrue(Gtin.matchesFormat(digits14));
    }

    @Test
    public void stringOf14LettersShouldNotMatchFormat() {
        String letters14 = "abcdefghijklmn";

        assertFalse(Gtin.matchesFormat(letters14));
    }

    @Test
    public void stringOf14LettersAndDigitsShouldNotMatchFormat() {
        String lettersAndDigits14 = "0a1b2c3d4e5f6g7h";

        assertFalse(Gtin.matchesFormat(lettersAndDigits14));
    }

    @Test
    public void stringOf15DigitsShouldNotMatchFormat() {
        String digits15 = "012345678901234";

        assertFalse(Gtin.matchesFormat(digits15));
    }

    @Test
    public void stringOf14DigitsShouldMatchSpecificGtinFormat() {
        String digits14 = "01234567890123";

        assertTrue(Gtin.matchesFormat(digits14, GtinFormat.GTIN_14));
    }

    @Test
    public void stringOf8DigitsShouldMatchFormat8() {
        String digits8 = "01234567";

        assertTrue(Gtin.matchesFormat8(digits8));
    }

    @Test
    public void stringOf12DigitsShouldMatchFormat12() {
        String digits12 = "012345678901";

        assertTrue(Gtin.matchesFormat12(digits12));
    }

    @Test
    public void stringOf8DigitsShouldNotMatchFormat12() {
        String digits8 = "01234567";

        assertFalse(Gtin.matchesFormat12(digits8));
    }

    @Test
    public void stringOf13DigitsShouldMatchFormat13() {
        String digits13 = "0123456789012";

        assertTrue(Gtin.matchesFormat13(digits13));
    }

    @Test
    public void stringOf12DigitsShouldNotMatchFormat13() {
        String digits12 = "012345678901";

        assertFalse(Gtin.matchesFormat13(digits12));
    }

    @Test
    public void stringOf14DigitsShouldNotMatchFormat13() {
        String digits14 = "01234567890123";

        assertFalse(Gtin.matchesFormat13(digits14));
    }

    @Test
    public void stringOf14DigitsShouldMatchFormat14() {
        String digits14 = "01234567890123";

        assertTrue(Gtin.matchesFormat14(digits14));
    }

    @Test
    public void stringOf13DigitsShouldNotMatchFormat14() {
        String digits13 = "0123456789012";

        assertFalse(Gtin.matchesFormat14(digits13));
    }

    @Test
    public void gtin8ShouldParseToGtin() {
        String gtin8 = "03485736";

        Gtin gtin = Gtin.create(gtin8);

        assertEquals(GtinFormat.GTIN_8, gtin.format());
        assertEquals(8, gtin.length());
        assertEquals(gtin8, gtin.toString());
    }

    @Test(expected = GtinFormatException.class)
    public void gtin8WithInvalidCheckDigitShouldNotParseToGtin() {
        String badGtin8 = "73513536";

        Gtin.create(badGtin8);
    }

    @Test
    public void gtin12ShouldParseToGtin() {
        String gtin12 = "734092309436";

        Gtin gtin = Gtin.create(gtin12);

        assertEquals(GtinFormat.GTIN_12, gtin.format());
        assertEquals(12, gtin.length());
        assertEquals(gtin12, gtin.toString());
    }

    @Test(expected = GtinFormatException.class)
    public void gtin12WithInvalidCheckDigitShouldNotParseToGtin() {
        String badGtin12 = "123456789010";

        Gtin.create(badGtin12);
    }

    @Test
    public void gtin13ShouldParseToGtin() {
        String gtin13 = "0234248273487";

        Gtin gtin = Gtin.create(gtin13);

        assertEquals(GtinFormat.GTIN_13, gtin.format());
        assertEquals(13, gtin.length());
        assertEquals(gtin13, gtin.toString());
    }

    @Test(expected = GtinFormatException.class)
    public void gtin13WithInvalidCheckDigitShouldNotParseToGtin() {
        String badGtin13 = "4006381333932";

        Gtin.create(badGtin13);
    }

    @Test
    public void gtin14ShouldParseToGtin() {
        String gtin14 = "10614141000415";

        Gtin gtin = Gtin.create(gtin14);

        assertEquals(GtinFormat.GTIN_14, gtin.format());
        assertEquals(14, gtin.length());
        assertEquals(gtin14, gtin.toString());
    }

    @Test(expected = GtinFormatException.class)
    public void gtin14WithInvalidCheckDigitShouldNotParseToGtin() {
        String badGtin14 = "10614141000416";

        Gtin.create(badGtin14);
    }

    @Test(expected = IllegalArgumentException.class)
    public void createNullShouldThrowException() {
        Gtin.create(null);
    }

    @Test
    public void gtinShouldBeEqualToItself() throws Exception {
        String gtin14 = "10614141000415";
        Gtin gtin = Gtin.create(gtin14);

        assertTrue(gtin.equals(gtin));
    }

    @Test
    public void sameGtinsShouldBeEqual() throws Exception {
        String gtin14 = "10614141000415";
        Gtin gtin1 = Gtin.create(gtin14);
        Gtin gtin2 = Gtin.create(gtin14);

        assertTrue(gtin1.equals(gtin2));
        assertTrue(gtin2.equals(gtin1));
    }

    @Test
    public void differentGtinsShouldNotBeEqual() throws Exception {
        String gtin13 = "0234248273487";
        String gtin14 = "10614141000415";
        Gtin gtin1 = Gtin.create(gtin14);
        Gtin gtin2 = Gtin.create(gtin13);

        assertFalse(gtin1.equals(gtin2));
        assertFalse(gtin2.equals(gtin1));
    }

    @Test
    public void gtinShouldNotBeEqualToObjectOfDifferentType() throws Exception {
        String gtin14 = "10614141000415";
        Gtin gtin = Gtin.create(gtin14);

        assertFalse(gtin.equals(gtin14));
        assertFalse(gtin.equals(new Object()));
    }

    @Test
    public void gtinHashCodeShouldBeConstant() throws Exception {
        String gtin14 = "10614141000415";
        Gtin gtin = Gtin.create(gtin14);

        int hashCode1 = gtin.hashCode();
        int hashCode2 = gtin.hashCode();

        assertEquals(hashCode1, hashCode2);
    }

    @Test
    public void sameGtinsShouldHaveEqualHashCodes() throws Exception {
        String gtin14 = "10614141000415";
        Gtin gtin1 = Gtin.create(gtin14);
        Gtin gtin2 = Gtin.create(gtin14);

        assertEquals(gtin1.hashCode(), gtin2.hashCode());
    }

    @Test
    public void differentGtinsShouldHaveUnequalHashCodesIfPossible() throws Exception {
        Gtin gtin1 = Gtin.create("10614141000415");
        Gtin gtin2 = Gtin.create("34957354738950");

        assertNotEquals(gtin1.hashCode(), gtin2.hashCode());
    }

    @Test
    public void gtin8CalculatedCheckDigitShouldBeCorrect() {
        String partialGtin8 = "7351353";

        int checkDigit = Gtin.calculateCheckDigit(partialGtin8);

        assertEquals(7, checkDigit);
    }

    @Test
    public void gtin12CalculatedCheckDigitShouldBeCorrect() {
        String partialGtin12 = "73409230943";

        int checkDigit = Gtin.calculateCheckDigit(partialGtin12);

        assertEquals(6, checkDigit);
    }

    @Test
    public void gtin13CalculatedCheckDigitShouldBeCorrect() {
        String partialGtin13 = "295248972349";

        int checkDigit = Gtin.calculateCheckDigit(partialGtin13);

        assertEquals(0, checkDigit);
    }

    @Test
    public void gtin14CalculatedCheckDigitShouldBeCorrect() {
        String partialGtin14 = "1061414100041";

        int checkDigit = Gtin.calculateCheckDigit(partialGtin14);

        assertEquals(5, checkDigit);
    }

    @Test(expected = GtinFormatException.class)
    public void stringOfLettersCheckDigitShouldThrowException() {
        String letters7 = "abcdefg";

        Gtin.calculateCheckDigit(letters7);
    }

    @Test(expected = IllegalArgumentException.class)
    public void calculateCheckDigitNullShouldThrowException() {
        Gtin.calculateCheckDigit(null);
    }

    @Test
    public void gtin8WithCheckDigitShouldBeCorrect() {
        String partialGtin8 = "7351353";

        String gtin8 = Gtin.withCheckDigit(partialGtin8);

        assertEquals("73513537", gtin8);
    }

    @Test(expected = GtinFormatException.class)
    public void stringOfLettersWithCheckDigitShouldThrowException() {
        String letters7 = "abcdefg";

        Gtin.withCheckDigit(letters7);
    }

    @Test
    public void gtin12WithCheckDigitShouldBeCorrect() {
        String partialGtin12 = "73409230943";

        String gtin12 = Gtin.withCheckDigit(partialGtin12);

        assertEquals("734092309436", gtin12);
    }

    @Test
    public void gtin13WithCheckDigitShouldBeCorrect() {
        String partialGtin13 = "023424827348";

        String gtin13 = Gtin.withCheckDigit(partialGtin13);

        assertEquals("0234248273487", gtin13);
    }

    @Test
    public void gtin14WithCheckDigitShouldBeCorrect() {
        String partialGtin14 = "1061414100041";

        String gtin14 = Gtin.withCheckDigit(partialGtin14);

        assertEquals("10614141000415", gtin14);
    }

    @Test(expected = IllegalArgumentException.class)
    public void withNullCheckDigitShouldThrowException() {
        Gtin.withCheckDigit(null);
    }

    @Test
    public void gtin14CreateWithCheckDigitShouldBeCorrect() {
        String partialGtin14 = "1061414100041";

        Gtin gtin14 = Gtin.createWithCheckDigit(partialGtin14);

        assertEquals("10614141000415", gtin14.toString());
    }

    @Test(expected = IllegalArgumentException.class)
    public void createWithNullCheckDigitShouldThrowException() {
        Gtin.createWithCheckDigit(null);
    }

    @Test
    public void gtin14CheckDigitShouldBeCorrect() {
        String gtin14 = "10614141000415";
        Gtin gtin = Gtin.create(gtin14);

        assertEquals(5, gtin.checkDigit());
    }

    @Test
    public void gtinDigitAtShouldBeCorrect() {
        String gtin14 = "10614141000415";
        Gtin gtin = Gtin.create(gtin14);

        assertEquals(1, gtin.digitAt(0));
        assertEquals(0, gtin.digitAt(1));
        assertEquals(6, gtin.digitAt(2));
        assertEquals(1, gtin.digitAt(12));
        assertEquals(5, gtin.digitAt(13));
    }

    @Test
    public void gtinAndDeserializedGtinShouldBeEqual() throws Exception {
        String gtin14 = "10614141000415";

        Gtin gtin = Gtin.create(gtin14);
        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        ObjectOutputStream oos = new ObjectOutputStream(buffer);
        oos.writeObject(gtin);
        oos.flush();
        oos.close();
        ByteArrayInputStream in = new ByteArrayInputStream(buffer.toByteArray());
        ObjectInputStream ois = new ObjectInputStream(in);
        Gtin deserializedGtin = (Gtin) ois.readObject();

        assertEquals(gtin, deserializedGtin);
        assertEquals(gtin.toString(), deserializedGtin.toString());
        assertEquals(gtin.format(), deserializedGtin.format());
        assertEquals(gtin.length(), deserializedGtin.length());
    }

}
