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

/**
 * Enumeration of the different GTIN formats.
 */
class GtinFormat {

  /**
   * GTIN-8, EAN-8. The short version of EAN-13 for extremely small products.
   */
  const GTIN_8 = new GtinFormat(8);

  /**
   * GTIN-12, UPC-A, UPC-12. Standard version of the UPC code.
   */
  const GTIN_12 = new GtinFormat(12),

  /**
   * GTIN-13, EAN-13. Primarily used in supermarkets to identify products at the point of sales.
   */
  const GTIN_13 = new GtinFormat(13),

  /**
   * GTIN-14, EAN-14. Commonly used for traded goods.
   */
  const GTIN_14 = new GtinFormat(14);

  private /*int*/ $length;

  private function __construct(/*int*/ $length) {
      this->length = length;
  }

  /**
   * Gets the GTIN format for the specified length.
   *
   * @param gtinLength the length of the GTIN.
   * @return the GTINFormat for the given length.
   * @throws InvalidArgumentException if the length does not match the length of any of the
   * known formats.
   */
  public static function /*GtinFormat*/ forLength(/*int*/ $gtinLength) {
    foreach (GtinFormat.values() as /*GtinFormat*/ $gtinFormat) {
      if ($gtinLength === gtinFormat.length()) {
        return gtinFormat;
      }
    }
    throw new InvalidArgumentException("Length '$gtinLength' does not match the "
        . "length of any known GTIN formats");
  }

  public static function /*GtinFormat[]*/ values() {
    return array(
      "GTIN_8" => GtinFormat::GTIN_8,
      "GTIN_12" => GtinFormat::GTIN_12,
      "GTIN_13" => GtinFormat::GTIN_13,
      "GTIN_14" => GtinFormat::GTIN_14
    );
  }

  public static function /*GtinFormat*/ valueOf(/*string*/ $name) {
    foreach (GtinFormat.values() as /*string*/ $key => /*GtinFormat*/ $gtinFormat) {
      if ($name === $key) {
        return $gtinFormat;
      }
    }
    throw new InvalidArgumentException("Name '$name' does not match the "
        . "name of any known GTIN formats");
  }

  /**
   * @return the length of this GTIN format.
   */
  public function /*int*/ length() {
    return $this->length;
  }

  /**
   * @return the name of the format, e.g. GTIN-12.
   */
  public function /*string*/ __toString() {
    return "GTIN-" . (string) $this->length;
  }

}
