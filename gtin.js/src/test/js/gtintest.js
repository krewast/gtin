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

QUnit.test("stringOf7DigitsShouldNotMatchFormat", function(assert) {
    var digits7 = "0123456";

    assert.ok(!Gtin.matchesFormat(digits7));
});

QUnit.test("stringOf7DigitsShouldNotBeValid", function(assert) {
    var digits7 = "0123456";

    assert.ok(!Gtin.isValid(digits7));
});

QUnit.test("stringOf8DigitsShouldMatchFormat", function(assert) {
    var digits8 = "01234567";

    assert.ok(Gtin.matchesFormat(digits8));
});

QUnit.test("stringOf8DigitsShouldMatchFormat8", function(assert) {
    var digits8 = "01234567";

    assert.ok(Gtin.matchesFormat8(digits8));
});

QUnit.test("stringOf8DigitsShouldNotMatchFormat12", function(assert) {
    var digits8 = "01234567";

    assert.ok(!Gtin.matchesFormat12(digits8));
});

QUnit.test("stringOf8LettersShouldNotMatchFormat", function(assert) {
    var letters8 = "abcdefgh";

    assert.ok(!Gtin.matchesFormat(letters8));
});

QUnit.test("stringOf8LettersShouldNotBeValid", function(assert) {
    var letters8 = "abcdefgh";

    assert.ok(!Gtin.isValid(letters8));
});

QUnit.test("stringOf8LettersAndDigitsShouldNotMatchFormat", function(assert) {
    var lettersAndDigits8 = "0a1b2c3d";

    assert.ok(!Gtin.matchesFormat(lettersAndDigits8));
});

QUnit.test("stringOf9DigitsShouldNotMatchFormat", function(assert) {
    var digits9 = "012345678";

    assert.ok(!Gtin.matchesFormat(digits9));
});

QUnit.test("stringOf11DigitsShouldNotMatchFormat", function(assert) {
    var digits11 = "01234567890";

    assert.ok(!Gtin.matchesFormat(digits11));
});

QUnit.test("stringOf12DigitsShouldMatchFormat", function(assert) {
    var digits12 = "012345678901";

    assert.ok(Gtin.matchesFormat(digits12));
});

QUnit.test("stringOf12DigitsShouldMatchFormat12", function(assert) {
    var digits12 = "012345678901";

    assert.ok(Gtin.matchesFormat12(digits12));
});

QUnit.test("stringOf12DigitsShouldNotMatchFormat13", function(assert) {
    var digits12 = "012345678901";

    assert.ok(!Gtin.matchesFormat13(digits12));
});

QUnit.test("stringOf12LettersShouldNotMatchFormat", function(assert) {
    var letters12 = "abcdefghijkl";

    assert.ok(!Gtin.matchesFormat(letters12));
});

QUnit.test("stringOf12LettersAndDigitsShouldNotMatchFormat", function(assert) {
    var lettersAndDigits12 = "0a1b2c3d4e5f6g";

    assert.ok(!Gtin.matchesFormat(lettersAndDigits12));
});

QUnit.test("stringOf13DigitsShouldMatchFormat", function(assert) {
    var digits13 = "0123456789012";

    assert.ok(Gtin.matchesFormat(digits13));
});

QUnit.test("stringOf13DigitsShouldMatchFormat13", function(assert) {
    var digits13 = "0123456789012";

    assert.ok(Gtin.matchesFormat13(digits13));
});

QUnit.test("stringOf13DigitsShouldNotMatchFormat14", function(assert) {
    var digits13 = "0123456789012";

    assert.ok(!Gtin.matchesFormat14(digits13));
});

QUnit.test("stringOf13LettersShouldNotMatchFormat", function(assert) {
    var letters13 = "abcdefghijklm";

    assert.ok(!Gtin.matchesFormat(letters13));
});

QUnit.test("stringOf13LettersAndDigitsShouldNotMatchFormat", function(assert) {
    var lettersAndDigits13 = "0a1b2c3d4e5f6g7";

    assert.ok(!Gtin.matchesFormat(lettersAndDigits13));
});

QUnit.test("stringOf14DigitsShouldMatchFormat", function(assert) {
    var digits14 = "01234567890123";

    assert.ok(Gtin.matchesFormat(digits14));
});

QUnit.test("stringOf14DigitsShouldMatchFormat14", function(assert) {
    var digits14 = "01234567890123";

    assert.ok(Gtin.matchesFormat14(digits14));
});

QUnit.test("stringOf14DigitsShouldMatchGtinFormat14", function(assert) {
    var digits14 = "01234567890123";

    assert.ok(Gtin.matchesFormat(digits14, GtinFormat.GTIN_14));
});

QUnit.test("stringOf14DigitsShouldNotMatchFormat13", function(assert) {
    var digits14 = "01234567890123";

    assert.ok(!Gtin.matchesFormat13(digits14));
});

QUnit.test("stringOf14LettersShouldNotMatchFormat", function(assert) {
    var letters14 = "abcdefghijklmn";

    assert.ok(!Gtin.matchesFormat(letters14));
});

QUnit.test("stringOf14LettersAndDigitsShouldNotMatchFormat", function(assert) {
    var lettersAndDigits14 = "0a1b2c3d4e5f6g7h";

    assert.ok(!Gtin.matchesFormat(lettersAndDigits14));
});

QUnit.test("stringOf15DigitsShouldNotMatchFormat", function(assert) {
    var digits15 = "012345678901234";

    assert.ok(!Gtin.matchesFormat(digits15));
});

QUnit.test("gtin8ShouldBeValid", function(assert) {
    var gtin8 = "73513537";

    assert.ok(Gtin.isValid(gtin8));
});

QUnit.test("gtin8ShouldBeValid8", function(assert) {
    var gtin8 = "03485736";

    assert.ok(Gtin.isValid8(gtin8));
});

QUnit.test("gtin8ShouldParseToGTIN", function(assert) {
    var gtin8 = "03485736";

    var gtin = Gtin.create(gtin8);

    assert.ok(GtinFormat.GTIN_8 == gtin.format);
    assert.ok(8 == gtin.length);
    assert.ok(gtin8 == gtin.toString());
});

QUnit.test("gtin8WithInvalidCheckDigitShouldNotBeValid", function(assert) {
    var badGtin8 = "73513536";

    assert.ok(!Gtin.isValid(badGtin8));
});

QUnit.test("gtin8WithInvalidCheckDigitShouldNotParseToGTIN", function(assert) {
    var badGtin8 = "73513536";

    assert.throws(function() { Gtin.create(badGtin8); }, GtinFormatError);
});

QUnit.test("gtin12ShouldBeValid", function(assert) {
    var gtin12 = "123456789012";

    assert.ok(Gtin.isValid(gtin12));
});

QUnit.test("gtin12ShouldBeValid12", function(assert) {
    var gtin12 = "734092309436";

    assert.ok(Gtin.isValid12(gtin12));
});

QUnit.test("gtin12ShouldParseToGTIN", function(assert) {
    var gtin12 = "734092309436";

    var gtin = Gtin.create(gtin12);

    assert.ok(GtinFormat.GTIN_12 == gtin.format);
    assert.ok(12 == gtin.length);
    assert.ok(gtin12 == gtin.toString());
});

QUnit.test("gtin12WithInvalidCheckDigitShouldNotBeValid", function(assert) {
    var badGtin12 = "123456789010";

    assert.ok(!Gtin.isValid(badGtin12));
});

QUnit.test("gtin12WithInvalidCheckDigitShouldNotParseToGTIN", function(assert) {
    var badGtin12 = "123456789010";

    assert.throws(function() { Gtin.create(badGtin12); }, GtinFormatError);
});

QUnit.test("gtin13ShouldBeValid", function(assert) {
    var gtin13 = "4006381333931";

    assert.ok(Gtin.isValid(gtin13));
});

QUnit.test("gtin13ShouldBeValid13", function(assert) {
    var gtin13 = "0234248273487";

    assert.ok(Gtin.isValid13(gtin13));
});

QUnit.test("gtin13ShouldNotBeValid14", function(assert) {
    var gtin13 = "0234248273487";

    assert.ok(!Gtin.isValid14(gtin13));
});

QUnit.test("gtin13ShouldParseToGTIN", function(assert) {
    var gtin13 = "0234248273487";

    var gtin = Gtin.create(gtin13);

    assert.ok(GtinFormat.GTIN_13 == gtin.format);
    assert.ok(13 == gtin.length);
    assert.ok(gtin13 == gtin.toString());
});

QUnit.test("gtin13WithInvalidCheckDigitShouldNotBeValid", function(assert) {
    var badGtin13 = "4006381333932";

    assert.ok(!Gtin.isValid(badGtin13));
});

QUnit.test("gtin13WithInvalidCheckDigitShouldNotParseToGTIN", function(assert) {
    var badGtin13 = "4006381333932";

    assert.throws(function() { Gtin.create(badGtin13); }, GtinFormatError);
});

QUnit.test("gtin14ShouldBeValid", function(assert) {
    var gtin14 = "10614141000415";

    assert.ok(Gtin.isValid(gtin14));
});

QUnit.test("gtin14ShouldBeValid14", function(assert) {
    var gtin14 = "34957354738950";

    assert.ok(Gtin.isValid14(gtin14));
});

QUnit.test("gtin14ShouldNotBeValid8", function(assert) {
    var gtin14 = "34957354738950";

    assert.ok(!Gtin.isValid8(gtin14));
});

QUnit.test("gtin14ShouldParseToGTIN", function(assert) {
    var gtin14 = "10614141000415";

    var gtin = Gtin.create(gtin14);

    assert.ok(GtinFormat.GTIN_14 == gtin.format);
    assert.ok(14 == gtin.length);
    assert.ok(gtin14 == gtin.toString());
});

QUnit.test("gtin14WithInvalidCheckDigitShouldNotBeValid", function(assert) {
    var badGtin14 = "10614141000416";

    assert.ok(!Gtin.isValid(badGtin14));
});

QUnit.test("gtin14WithInvalidCheckDigitShouldNotParseToGTIN", function(assert) {
    var badGtin14 = "10614141000416";

    assert.throws(function() { Gtin.create(badGtin14); }, GtinFormatError);
});

QUnit.test("gtinShouldBeEqualToItself", function(assert) {
    var gtin14 = "10614141000415";
    var gtin = Gtin.create(gtin14);

    assert.ok(gtin.equals(gtin));
});

QUnit.test("sameGtinsShouldBeEqual", function(assert) {
    var gtin14 = "10614141000415";
    var gtin1 = Gtin.create(gtin14);
    var gtin2 = Gtin.create(gtin14);

    assert.ok(gtin1.equals(gtin2));
    assert.ok(gtin2.equals(gtin1));
});

QUnit.test("differentGtinsShouldNotBeEqual", function(assert) {
    var gtin13 = "0234248273487";
    var gtin14 = "10614141000415";
    var gtin1 = Gtin.create(gtin14);
    var gtin2 = Gtin.create(gtin13);

    assert.ok(!gtin1.equals(gtin2));
    assert.ok(!gtin2.equals(gtin1));
});

QUnit.test("gtinShouldNotBeEqualToObjectOfDifferentType", function(assert) {
    var gtin14 = "10614141000415";
    var gtin = Gtin.create(gtin14);

    assert.ok(!gtin.equals(gtin14));
    assert.ok(!gtin.equals(true));
});

QUnit.test("gtinHashCodeShouldBeConstant", function(assert) {
    var gtin14 = "10614141000415";
    var gtin = Gtin.create(gtin14);

    var hashCode1 = gtin.hashCode();
    var hashCode2 = gtin.hashCode();

    assert.ok(hashCode1 == hashCode2);
});

QUnit.test("sameGtinsShouldHaveEqualHashCodes", function(assert) {
    var gtin14 = "10614141000415";
    var gtin1 = Gtin.create(gtin14);
    var gtin2 = Gtin.create(gtin14);

    assert.ok(gtin1.hashCode() == gtin2.hashCode());
});

QUnit.test("differentGtinsShouldHaveUnequalHashCodesIfPossible", function(assert) {
    var gtin1 = Gtin.create("10614141000415");
    var gtin2 = Gtin.create("34957354738950");

    assert.ok(gtin1.hashCode() != gtin2.hashCode());
});

QUnit.test("gtin8CalculatedCheckDigitShouldBeCorrect", function(assert) {
    var partialGtin8 = "7351353";

    var checkDigit = Gtin.calculateCheckDigit(partialGtin8);

    assert.ok(7 == checkDigit);
});

QUnit.test("gtin12CalculatedCheckDigitShouldBeCorrect", function(assert) {
    var partialGtin12 = "73409230943";

    var checkDigit = Gtin.calculateCheckDigit(partialGtin12);

    assert.ok(6 == checkDigit);
});

QUnit.test("gtin13CalculatedCheckDigitShouldBeCorrect", function(assert) {
    var partialGtin13 = "295248972349";

    var checkDigit = Gtin.calculateCheckDigit(partialGtin13);

    assert.ok(0 === checkDigit);
});

QUnit.test("gtin14CalculatedCheckDigitShouldBeCorrect", function(assert) {
    var partialGtin14 = "1061414100041";

    var checkDigit = Gtin.calculateCheckDigit(partialGtin14);

    assert.ok(5 == checkDigit);
});

QUnit.test("gtin8WithCheckDigitShouldBeCorrect", function(assert) {
    var partialGtin8 = "7351353";

    var gtin8 = Gtin.withCheckDigit(partialGtin8);

    assert.ok("73513537" == gtin8);
});

QUnit.test("stringOfLettersCheckDigitShouldThrowException", function(assert) {
    var letters8 = "abcdefgh";

    assert.throws(function() { Gtin.calculateCheckDigit(letters8); }, GtinFormatError);
});

QUnit.test("stringOfLettersWithCheckDigitShouldThrowException", function(assert) {
    var letters8 = "abcdefgh";

    assert.throws(function() { Gtin.withCheckDigit(letters8); }, GtinFormatError);
});

QUnit.test("gtin12WithCheckDigitShouldBeCorrect", function(assert) {
    var partialGtin12 = "73409230943";

    var gtin12 = Gtin.withCheckDigit(partialGtin12);

    assert.ok("734092309436" == gtin12);
});

QUnit.test("gtin13WithCheckDigitShouldBeCorrect", function(assert) {
    var partialGtin13 = "023424827348";

    var gtin13 = Gtin.withCheckDigit(partialGtin13);

    assert.ok("0234248273487" == gtin13);
});

QUnit.test("gtin14WithCheckDigitShouldBeCorrect", function(assert) {
    var partialGtin14 = "1061414100041";

    var gtin14 = Gtin.withCheckDigit(partialGtin14);

    assert.ok("10614141000415" == gtin14);
});

QUnit.test("gtin14CreateWithCheckDigitShouldBeCorrect", function(assert) {
    var partialGtin14 = "1061414100041";

    var gtin14 = Gtin.createWithCheckDigit(partialGtin14);

    assert.ok("10614141000415" == gtin14.toString());
});

QUnit.test("gtin14CheckDigitShouldBeCorrect", function(assert) {
    var gtin14 = "10614141000415";
    var gtin = Gtin.create(gtin14);

    assert.ok(5 == gtin.checkDigit());
});

QUnit.test("gtinDigitAtShouldBeCorrect", function(assert) {
    var gtin14 = "10614141000415";
    var gtin = Gtin.create(gtin14);

    assert.ok(1 == gtin.digitAt(0));
    assert.ok(0 === gtin.digitAt(1));
    assert.ok(6 == gtin.digitAt(2));
    assert.ok(1 == gtin.digitAt(12));
    assert.ok(5 == gtin.digitAt(13));
});

QUnit.test("validateNullShouldThrowException", function(assert) {
    assert.throws(function() { Gtin.isValid(null); });
});

QUnit.test("calculateCheckDigitNullShouldThrowException", function(assert) {
    assert.throws(function() { Gtin.calculateCheckDigit(null); });
});

QUnit.test("withNullCheckDigitShouldThrowException", function(assert) {
    assert.throws(function() { Gtin.withCheckDigit(null); });
});

QUnit.test("createNullShouldThrowException", function(assert) {
    assert.throws(function() { Gtin.create(null); });
});

QUnit.test("createWithNullCheckDigitShouldThrowException", function(assert) {
    assert.throws(function() { Gtin.createWithCheckDigit(null); });
});
