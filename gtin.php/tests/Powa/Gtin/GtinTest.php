<?php
/**
 * Copyright ($C) 2015 Powa Technologies Ltd.
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
namespace Powa\Gtin;

class GtinTest extends \PHPUnit_Framework_TestCase {

  public function /*void*/ testStringOf7DigitsShouldNotBeValid() {
    /*string*/ $digits7 = "0123456";

    $this->assertFalse(Gtin::isValid($digits7));
  }

  public function /*void*/ testGtin8ShouldBeValid() {
    /*string*/ $gtin8 = "73513537";

    $this->assertTrue(Gtin::isValid($gtin8));
  }

  public function /*void*/ testStringOf8LettersShouldNotBeValid() {
    /*string*/ $letters8 = "abcdefgh";

    $this->assertFalse(Gtin::isValid($letters8));
  }

  public function /*void*/ testGtin8WithInvalidCheckDigitShouldNotBeValid() {
    /*string*/ $badGtin8 = "73513536";

    $this->assertFalse(Gtin::isValid($badGtin8));
  }

  public function /*void*/ testGtin12ShouldBeValid() {
    /*string*/ $gtin12 = "123456789012";

    $this->assertTrue(Gtin::isValid($gtin12));
  }

  public function /*void*/ testGtin12WithInvalidCheckDigitShouldNotBeValid() {
    /*string*/ $badGtin12 = "123456789010";

    $this->assertFalse(Gtin::isValid($badGtin12));
  }

  public function /*void*/ testGtin13ShouldBeValid() {
    /*string*/ $gtin13 = "4006381333931";

    $this->assertTrue(Gtin::isValid($gtin13));
  }

  public function /*void*/ testGtin13WithInvalidCheckDigitShouldNotBeValid() {
    /*string*/ $badGtin13 = "4006381333932";

    $this->assertFalse(Gtin::isValid($badGtin13));
  }

  public function /*void*/ testGtin14ShouldBeValid() {
    /*string*/ $gtin14 = "10614141000415";

    $this->assertTrue(Gtin::isValid($gtin14));
  }

  public function /*void*/ testGtin14WithInvalidCheckDigitShouldNotBeValid() {
    /*string*/ $badGtin14 = "10614141000416";

    $this->assertFalse(Gtin::isValid($badGtin14));
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testValidateNullShouldThrowException() {
    Gtin::isValid(null);
  }

  public function /*void*/ testGtin8ShouldBeValid8() {
    /*string*/ $gtin8 = "03485736";

    $this->assertTrue(Gtin::isValid8($gtin8));
  }

  public function /*void*/ testGtin14ShouldNotBeValid8() {
    /*string*/ $gtin14 = "34957354738950";

    $this->assertFalse(Gtin::isValid8($gtin14));
  }

  public function /*void*/ testGtin12ShouldBeValid12() {
    /*string*/ $gtin12 = "734092309436";

    $this->assertTrue(Gtin::isValid12($gtin12));
  }

  public function /*void*/ testGtin13ShouldBeValid13() {
    /*string*/ $gtin13 = "0234248273487";

    $this->assertTrue(Gtin::isValid13($gtin13));
  }

  public function /*void*/ testGtin14ShouldBeValid14() {
    /*string*/ $gtin14 = "34957354738950";

    $this->assertTrue(Gtin::isValid14($gtin14));
  }

  public function /*void*/ testGtin13ShouldNotBeValid14() {
    /*string*/ $gtin13 = "0234248273487";

    $this->assertFalse(Gtin::isValid14($gtin13));
  }

  public function /*void*/ testStringOf7DigitsShouldNotMatchFormat() {
    /*string*/ $digits7 = "0123456";

    $this->assertFalse(Gtin::matchesFormat($digits7));
  }

  public function /*void*/ testStringOf8DigitsShouldMatchFormat() {
    /*string*/ $digits8 = "01234567";

    $this->assertTrue(Gtin::matchesFormat($digits8));
  }

  public function /*void*/ testStringOf8LettersShouldNotMatchFormat() {
    /*string*/ $letters8 = "abcdefgh";

    $this->assertFalse(Gtin::matchesFormat($letters8));
  }

  public function /*void*/ testStringOf8LettersAndDigitsShouldNotMatchFormat() {
    /*string*/ $lettersAndDigits8 = "0a1b2c3d";

    $this->assertFalse(Gtin::matchesFormat($lettersAndDigits8));
  }

  public function /*void*/ testStringOf9DigitsShouldNotMatchFormat() {
    /*string*/ $digits9 = "012345678";

    $this->assertFalse(Gtin::matchesFormat($digits9));
  }

  public function /*void*/ testStringOf11DigitsShouldNotMatchFormat() {
    /*string*/ $digits11 = "01234567890";

    $this->assertFalse(Gtin::matchesFormat($digits11));
  }

  public function /*void*/ testStringOf12DigitsShouldMatchFormat() {
    /*string*/ $digits12 = "012345678901";

    $this->assertTrue(Gtin::matchesFormat($digits12));
  }

  public function /*void*/ testStringOf12LettersShouldNotMatchFormat() {
    /*string*/ $letters12 = "abcdefghijkl";

    $this->assertFalse(Gtin::matchesFormat($letters12));
  }

  public function /*void*/ testStringOf12LettersAndDigitsShouldNotMatchFormat() {
    /*string*/ $lettersAndDigits12 = "0a1b2c3d4e5f6g";

    $this->assertFalse(Gtin::matchesFormat($lettersAndDigits12));
  }

  public function /*void*/ testStringOf13DigitsShouldMatchFormat() {
    /*string*/ $digits13 = "0123456789012";

    $this->assertTrue(Gtin::matchesFormat($digits13));
  }

  public function /*void*/ testStringOf13LettersShouldNotMatchFormat() {
    /*string*/ $letters13 = "abcdefghijklm";

    $this->assertFalse(Gtin::matchesFormat($letters13));
  }

  public function /*void*/ testStringOf13LettersAndDigitsShouldNotMatchFormat() {
    /*string*/ $lettersAndDigits13 = "0a1b2c3d4e5f6g7";

    $this->assertFalse(Gtin::matchesFormat($lettersAndDigits13));
  }

  public function /*void*/ testStringOf14DigitsShouldMatchFormat() {
    /*string*/ $digits14 = "01234567890123";

    $this->assertTrue(Gtin::matchesFormat($digits14));
  }

  public function /*void*/ testStringOf14LettersShouldNotMatchFormat() {
    /*string*/ $letters14 = "abcdefghijklmn";

    $this->assertFalse(Gtin::matchesFormat($letters14));
  }

  public function /*void*/ testStringOf14LettersAndDigitsShouldNotMatchFormat() {
    /*string*/ $lettersAndDigits14 = "0a1b2c3d4e5f6g7h";

    $this->assertFalse(Gtin::matchesFormat($lettersAndDigits14));
  }

  public function /*void*/ testStringOf15DigitsShouldNotMatchFormat() {
    /*string*/ $digits15 = "012345678901234";

    $this->assertFalse(Gtin::matchesFormat($digits15));
  }

  public function /*void*/ testStringOf14DigitsShouldMatchSpecificGtinFormat() {
    /*string*/ $digits14 = "01234567890123";

    $this->assertTrue(Gtin::matchesFormat($digits14, GtinFormat::GTIN_14()));
  }

  public function /*void*/ testStringOf8DigitsShouldMatchFormat8() {
    /*string*/ $digits8 = "01234567";

    $this->assertTrue(Gtin::matchesFormat8($digits8));
  }

  public function /*void*/ testStringOf12DigitsShouldMatchFormat12() {
    /*string*/ $digits12 = "012345678901";

    $this->assertTrue(Gtin::matchesFormat12($digits12));
  }

  public function /*void*/ testStringOf8DigitsShouldNotMatchFormat12() {
    /*string*/ $digits8 = "01234567";

    $this->assertFalse(Gtin::matchesFormat12($digits8));
  }

  public function /*void*/ testStringOf13DigitsShouldMatchFormat13() {
    /*string*/ $digits13 = "0123456789012";

    $this->assertTrue(Gtin::matchesFormat13($digits13));
  }

  public function /*void*/ testStringOf12DigitsShouldNotMatchFormat13() {
    /*string*/ $digits12 = "012345678901";

    $this->assertFalse(Gtin::matchesFormat13($digits12));
  }

  public function /*void*/ testStringOf14DigitsShouldNotMatchFormat13() {
    /*string*/ $digits14 = "01234567890123";

    $this->assertFalse(Gtin::matchesFormat13($digits14));
  }

  public function /*void*/ testStringOf14DigitsShouldMatchFormat14() {
    /*string*/ $digits14 = "01234567890123";

    $this->assertTrue(Gtin::matchesFormat14($digits14));
  }

  public function /*void*/ testStringOf13DigitsShouldNotMatchFormat14() {
    /*string*/ $digits13 = "0123456789012";

    $this->assertFalse(Gtin::matchesFormat14($digits13));
  }

  public function /*void*/ testGtin8ShouldParseToGtin() {
    /*string*/ $gtin8 = "03485736";

    /*Gtin*/ $gtin = Gtin::create($gtin8);

    $this->assertEquals(GtinFormat::GTIN_8(), $gtin->format());
    $this->assertEquals(8, $gtin->length());
    $this->assertEquals($gtin8, (string) $gtin);
  }

  /**
   * @expectedException Powa\Gtin\GtinFormatException
   */
  public function /*void*/ testGtin8WithInvalidCheckDigitShouldNotParseToGtin() {
      /*string*/ $badGtin8 = "73513536";

      Gtin::create($badGtin8);
  }

  public function /*void*/ testGtin12ShouldParseToGtin() {
    /*string*/ $gtin12 = "734092309436";

    /*Gtin*/ $gtin = Gtin::create($gtin12);

    $this->assertEquals(GtinFormat::GTIN_12(), $gtin->format());
    $this->assertEquals(12, $gtin->length());
    $this->assertEquals($gtin12, (string) $gtin);
  }

  /**
   * @expectedException Powa\Gtin\GtinFormatException
   */
  public function /*void*/ testGtin12WithInvalidCheckDigitShouldNotParseToGtin() {
      /*string*/ $badGtin12 = "123456789010";

      Gtin::create($badGtin12);
  }

  public function /*void*/ testGtin13ShouldParseToGtin() {
    /*string*/ $gtin13 = "0234248273487";

    /*Gtin*/ $gtin = Gtin::create($gtin13);

    $this->assertEquals(GtinFormat::GTIN_13(), $gtin->format());
    $this->assertEquals(13, $gtin->length());
    $this->assertEquals($gtin13, (string) $gtin);
  }

  /**
   * @expectedException Powa\Gtin\GtinFormatException
   */
  public function /*void*/ testGtin13WithInvalidCheckDigitShouldNotParseToGtin() {
      /*string*/ $badGtin13 = "4006381333932";

      Gtin::create($badGtin13);
  }

  public function /*void*/ testGtin14ShouldParseToGtin() {
    /*string*/ $gtin14 = "10614141000415";

    /*Gtin*/ $gtin = Gtin::create($gtin14);

    $this->assertEquals(GtinFormat::GTIN_14(), $gtin->format());
    $this->assertEquals(14, $gtin->length());
    $this->assertEquals($gtin14, (string) $gtin);
  }

  /**
   * @expectedException Powa\Gtin\GtinFormatException
   */
  public function /*void*/ testGtin14WithInvalidCheckDigitShouldNotParseToGtin() {
    /*string*/ $badGtin14 = "10614141000416";

    Gtin::create($badGtin14);
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testCreateNullShouldThrowException() {
      Gtin::create(null);
  }

  public function /*void*/ testGtinShouldBeEqualToItself() {
    /*string*/ $gtin14 = "10614141000415";
    /*Gtin*/ $gtin = Gtin::create($gtin14);

    $this->assertTrue($gtin == $gtin);
  }

  public function /*void*/ testSameGtinsShouldBeEqual() {
    /*string*/ $gtin14 = "10614141000415";
    /*Gtin*/ $gtin1 = Gtin::create($gtin14);
    /*Gtin*/ $gtin2 = Gtin::create($gtin14);

    $this->assertTrue($gtin1 == $gtin2);
    $this->assertTrue($gtin2 == $gtin1);
  }

  public function /*void*/ testDifferentGtinsShouldNotBeEqual() {
    /*string*/ $gtin13 = "0234248273487";
    /*string*/ $gtin14 = "10614141000415";
    /*Gtin*/ $gtin1 = Gtin::create($gtin14);
    /*Gtin*/ $gtin2 = Gtin::create($gtin13);

    $this->assertFalse($gtin1 == $gtin2);
    $this->assertFalse($gtin2 == $gtin1);
  }

  public function /*void*/ testGtinShouldNotBeEqualToObjectOfDifferentType() {
    /*string*/ $gtin14 = "10614141000415";
    /*Gtin*/ $gtin = Gtin::create($gtin14);

    $this->assertFalse($gtin === $gtin14);
    $this->assertFalse($gtin == new \Exception());
  }

  public function /*void*/ testGtin8CalculatedCheckDigitShouldBeCorrect() {
    /*string*/ $partialGtin8 = "7351353";

    /*int*/ $checkDigit = Gtin::calculateCheckDigit($partialGtin8);

    $this->assertEquals(7, $checkDigit);
  }

  public function /*void*/ testGtin12CalculatedCheckDigitShouldBeCorrect() {
    /*string*/ $partialGtin12 = "73409230943";

    /*int*/ $checkDigit = Gtin::calculateCheckDigit($partialGtin12);

    $this->assertEquals(6, $checkDigit);
  }

  public function /*void*/ testGtin13CalculatedCheckDigitShouldBeCorrect() {
    /*string*/ $partialGtin13 = "295248972349";

    /*int*/ $checkDigit = Gtin::calculateCheckDigit($partialGtin13);

    $this->assertEquals(0, $checkDigit);
  }

  public function /*void*/ testGtin14CalculatedCheckDigitShouldBeCorrect() {
    /*string*/ $partialGtin14 = "1061414100041";

    /*int*/ $checkDigit = Gtin::calculateCheckDigit($partialGtin14);

    $this->assertEquals(5, $checkDigit);
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testStringOfLettersCheckDigitShouldThrowException() {
    /*string*/ $letters7 = "abcdefg";

    Gtin::calculateCheckDigit($letters7);
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testCalculateCheckDigitNullShouldThrowException() {
    Gtin::calculateCheckDigit(null);
  }

  public function /*void*/ testGtin8WithCheckDigitShouldBeCorrect() {
    /*string*/ $partialGtin8 = "7351353";

    /*string*/ $gtin8 = Gtin::withCheckDigit($partialGtin8);

    $this->assertEquals("73513537", $gtin8);
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testStringOfLettersWithCheckDigitShouldThrowException() {
    /*string*/ $letters7 = "abcdefg";

    Gtin::withCheckDigit($letters7);
  }

  public function /*void*/ testGtin12WithCheckDigitShouldBeCorrect() {
    /*string*/ $partialGtin12 = "73409230943";

    /*string*/ $gtin12 = Gtin::withCheckDigit($partialGtin12);

    $this->assertEquals("734092309436", $gtin12);
  }

  public function /*void*/ testGtin13WithCheckDigitShouldBeCorrect() {
    /*string*/ $partialGtin13 = "023424827348";

    /*string*/ $gtin13 = Gtin::withCheckDigit($partialGtin13);

    $this->assertEquals("0234248273487", $gtin13);
  }

  public function /*void*/ testGtin14WithCheckDigitShouldBeCorrect() {
    /*string*/ $partialGtin14 = "1061414100041";

    /*string*/ $gtin14 = Gtin::withCheckDigit($partialGtin14);

    $this->assertEquals("10614141000415", (string) $gtin14);
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testWithNullCheckDigitShouldThrowException() {
    Gtin::withCheckDigit(null);
  }

  public function /*void*/ testGtin14CreateWithCheckDigitShouldBeCorrect() {
    /*string*/ $partialGtin14 = "1061414100041";

    /*Gtin*/ $gtin14 = Gtin::createWithCheckDigit($partialGtin14);

    $this->assertEquals("10614141000415", (string) $gtin14);
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testCreateWithNullCheckDigitShouldThrowException() {
    Gtin::createWithCheckDigit(null);
  }

  public function /*void*/ testGtin14CheckDigitShouldBeCorrect() {
    /*string*/ $gtin14 = "10614141000415";
    /*Gtin*/ $gtin = Gtin::create($gtin14);

    $this->assertEquals(5, $gtin->checkDigit());
  }

  public function /*void*/ testGtinDigitAtShouldBeCorrect() {
    /*string*/ $gtin14 = "10614141000415";
    /*Gtin*/ $gtin = Gtin::create($gtin14);

    $this->assertEquals(1, $gtin->digitAt(0));
    $this->assertEquals(0, $gtin->digitAt(1));
    $this->assertEquals(6, $gtin->digitAt(2));
    $this->assertEquals(1, $gtin->digitAt(12));
    $this->assertEquals(5, $gtin->digitAt(13));
  }

}
