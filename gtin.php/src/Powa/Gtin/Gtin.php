<?php
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
namespace Powa\Gtin;

use Powa\Gtin\GtinFormat;
use Powa\Gtin\GtinFormatException;

/**
 * Valid GTIN code. Static methods are provided for identifying, validating and parsing GTIN codes
 * represented as strings.
 */
final class Gtin {

  private /*string*/ $gtin;
  private /*GtinFormat*/ $format;

  // Prevent instantiation
  private function __construct(/*string*/ $gtin) {
    $this->gtin = $gtin;
    $this->format = GtinFormat::forLength(strlen($gtin));
  }

  /**
   * Creates a GTIN from the given string.
   * You may use the {@link #isValid(String)} method first if you are unsure whether the
   * string is a valid GTIN to avoid a GtinFormatException being thrown.
   *
   * @param gtin the GTIN string.
   * @return a GTIN object if the string is a valid GTIN.
   * @throws GtinFormatException if the string is not a valid GTIN.
   */
  public static function /*Gtin*/ create(/*string*/ $gtin) {
    if (!self::isValid($gtin)) {
      throw new GtinFormatException("String '$gtin' is not a valid gtin");
    }
    return new Gtin($gtin);
  }

  /**
   * Creates a GTIN from the given partial GTIN string without the check digit.
   *
   * @param gtinWithoutCheckDigit the GTIN without the final check digit.
   * @return a GTIN object if the string is a valid GTIN.
   * @throws GtinFormatException if the string is not a valid partial GTIN.
   */
  public static function /*Gtin*/ createWithCheckDigit(/*string*/ $gtinWithoutCheckDigit) {
    return new Gtin(self::withCheckDigit($gtinWithoutCheckDigit));
  }

  /**
   * Checks if the string is a valid specific GTIN format by checking the format, length
   * and checksum.
   *
   * @param gtin the GTIN string to check, may be GTIN-8, GTIN-12, GTIN-13 or GTIN-14 format.
   * @param format the optional, GTIN format to check the string against.
   * @return {@code true} if the GTIN is valid, {@code false} otherwise.
   */
  public static function /*boolean*/ isValid(/*string*/ $gtin, GtinFormat $format = null) {
    // Check format of barcode for validity
    if (!self::matchesFormat($gtin)) {
      return false;
    }
    /*int*/ $gtinLength = strlen($gtin);
    if ($format !== null && $gtinLength != $format->length()) {
      return false;
    }
    /*int*/ $checkSum = 0;
    /*int*/ $weightBit = $gtinLength % 2;
    for (/*int*/ $i = 0; $i < $gtinLength; $i++) {
      /*int*/ $weight = $i % 2 === $weightBit ? 3 : 1;
      $checkSum += intval(substr($gtin, $i, 1)) * $weight;
    }
    return $checkSum % 10 === 0;
  }

  /**
   * Checks if the string is a valid GTIN-8 by checking the format and checksum.
   *
   * @param gtin the GTIN-8 string to check.
   * @return {@code true} if the GTIN is valid, {@code false} otherwise.
   */
  public static function /*boolean*/ isValid8(/*string*/ $gtin) {
    return self::isValid($gtin, GtinFormat::GTIN_8());
  }

  /**
   * Checks if the string is a valid GTIN-12 by checking the format and checksum.
   *
   * @param gtin the GTIN-12 string to check.
   * @return {@code true} if the GTIN is valid, {@code false} otherwise.
   */
  public static function /*boolean*/ isValid12(/*string*/ $gtin) {
    return self::isValid($gtin, GtinFormat::GTIN_12());
  }

  /**
   * Checks if the string is a valid GTIN-13 by checking the format and checksum.
   *
   * @param gtin the GTIN-13 string to check.
   * @return {@code true} if the GTIN is valid, {@code false} otherwise.
   */
  public static function /*boolean*/ isValid13(/*string*/ $gtin) {
    return self::isValid($gtin, GtinFormat::GTIN_13());
  }

  /**
   * Checks if the string is a valid GTIN-14 by checking the format and checksum.
   *
   * @param gtin the GTIN-14 string to check.
   * @return {@code true} if the GTIN is valid, {@code false} otherwise.
   */
  public static function /*boolean*/ isValid14(/*string*/ $gtin) {
    return self::isValid($gtin, GtinFormat::GTIN_14());
  }

  /**
   * Calculates the check digit for a partial GTIN.
   *
   * @param gtinWithoutCheckDigit the GTIN without the final check digit.
   * @return the check digit to complete the GTIN code.
   * @throws GtinFormatException if the string is not a valid partial GTIN without the check
   * digit.
   */
  public static function /*int*/ calculateCheckDigit(/*string*/ $gtinWithoutCheckDigit) {
    if (!self::matchesFormatWithOffset($gtinWithoutCheckDigit, null, 1)) {
      throw new GtinFormatException("String '$gtinWithoutCheckDigit' is not a valid partial gtin");
    }
    /*int*/ $checkSum = 0;
    /*int*/ $gtinLength = strlen($gtinWithoutCheckDigit);
    /*int*/ $weightBit = ($gtinLength + 1) % 2;
    for (/*int*/ $i = 0; $i < $gtinLength; $i++) {
      /*int*/ $weight = $i % 2 === $weightBit ? 3 : 1;
      $checkSum += intval(substr($gtinWithoutCheckDigit, $i, 1)) * $weight;
    }
    return $checkSum % 10 == 0 ? 0 : 10 - ($checkSum % 10);
  }

  /**
   * Returns the given partial GTIN code with check digit added.
   *
   * @param gtinWithoutCheckDigit the GTIN without the final check digit.
   * @return the GTIN code with check digit.
   * @throws GtinFormatException if the string is not a valid partial GTIN without the check
   * digit.
   */
  public static function /*string*/ withCheckDigit(/*string*/ $gtinWithoutCheckDigit) {
    return $gtinWithoutCheckDigit . (string) self::calculateCheckDigit($gtinWithoutCheckDigit);
  }

  /**
   * Checks whether the input string matches the GTIN format, i.e. is of the correct
   * length that format GTIN and that the string contains only digits.
   *
   * @param gtin the possible GTIN string.
   * @param format optional, the GTIN format to check the string against.
   * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
   */
  public static function /*boolean*/ matchesFormat(/*string*/ $gtin, GtinFormat $format = null) {
    return self::matchesFormatWithOffset($gtin, $format, 0);
  }

  private static function /*boolean*/ matchesFormatWithOffset(/*string*/ $gtin, GtinFormat $format = null, /*int*/ $offset = 0) {
    if ($gtin === null) {
      throw new \InvalidArgumentException("gtin is null");
    }
    // Check length
    /*int*/ $gtinLength = strlen($gtin);
    /*boolean*/ $validLength = false;
    if ($format !== null) {
      $validLength = $gtinLength === $format->length();
    } else {
      foreach (GtinFormat::values() as $gtinFormat) {
        if ($gtinLength === $gtinFormat->length() - $offset) {
          $validLength = true;
          break;
        }
      }
    }
    if (!$validLength) {
      return false;
    }
    // Check whether is a number
    return preg_match('/^[0-9]+$/', $gtin) === 1;
  }

  /**
   * Checks whether the input string matches the GTIN-8 format, i.e. is of the correct
   * length and that the string contains only digits.
   *
   * @param gtin the possible GTIN string.
   * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
   */
  public static function /*boolean*/ matchesFormat8(/*string*/ $gtin) {
    return self::matchesFormatWithOffset($gtin, GtinFormat::GTIN_8(), 0);
  }

  /**
   * Checks whether the input string matches the GTIN-12 format, i.e. is of the correct
   * length and that the string contains only digits.
   *
   * @param gtin the possible GTIN string.
   * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
   */
  public static function /*boolean*/ matchesFormat12(/*string*/ $gtin) {
    return self::matchesFormatWithOffset($gtin, GtinFormat::GTIN_12(), 0);
  }

  /**
   * Checks whether the input string matches the GTIN-13 format, i.e. is of the correct
   * length and that the string contains only digits.
   *
   * @param gtin the possible GTIN string.
   * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
   */
  public static function /*boolean*/ matchesFormat13(/*string*/ $gtin) {
    return self::matchesFormatWithOffset($gtin, GtinFormat::GTIN_13(), 0);
  }

  /**
   * Checks whether the input string matches the GTIN-14 format, i.e. is of the correct
   * length and that the string contains only digits.
   *
   * @param gtin the possible GTIN string.
   * @return {@code true} if the input string is a valid GTIN string, {@code false} otherwise.
   */
  public static function /*boolean*/ matchesFormat14(/*string*/ $gtin) {
    return self::matchesFormatWithOffset($gtin, GtinFormat::GTIN_14(), 0);
  }

  /**
   * @return the format or type of this GTIN.
   */
  public function /*GtinFormat*/ format() {
    return $this->format;
  }

  /**
   * @return the length of this GTIN.
   */
  public function /*int*/ length() {
    return $this->format->length();
  }

  /**
   * @return the check digit of this GTIN.
   */
  public function /*int*/ checkDigit() {
    return intval(substr($this->gtin, strlen($this->gtin) - 1));
  }

  /**
   * Gets the digit at the specified position.
   *
   * @param position the position, from 0 to length - 1.
   * @return the digit at the specified position.
   */
  public function /*int*/ digitAt(/*int*/ $position) {
    return intval(substr($this->gtin, $position, 1));
  }

  /**
   * @return this GTIN code as a string.
   */
  public function /*string*/ __toString() {
    return $this->gtin;
  }

}
