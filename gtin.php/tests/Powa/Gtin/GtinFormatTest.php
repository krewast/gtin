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

class GtinFormatTest extends \PHPUnit_Framework_TestCase {

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testForLength7ShouldThrowException() {
    GtinFormat::forLength(7);
  }

  public function /*void*/ testForLength8ShouldReturnGtin8() {
    $this->assertEquals(GtinFormat::GTIN_8(), GtinFormat::forLength(8));
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testForLength9ShouldThrowException() {
    GtinFormat::forLength(9);
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testForLength11ShouldThrowException() {
    GtinFormat::forLength(11);
  }

  public function /*void*/ testForLength12ShouldReturnGtin12() {
    $this->assertEquals(GtinFormat::GTIN_12(), GtinFormat::forLength(12));
  }

  public function /*void*/ testForLength13ShouldReturnGtin13() {
    $this->assertEquals(GtinFormat::GTIN_13(), GtinFormat::forLength(13));
  }

  public function /*void*/ testForLength14ShouldReturnGtin14() {
    $this->assertEquals(GtinFormat::GTIN_14(), GtinFormat::forLength(14));
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testForLength15ShouldThrowException() {
    GtinFormat::forLength(15);
  }

  public function /*void*/ testValueOf() {
    $this->assertEquals(GtinFormat::GTIN_8(), GtinFormat::valueOf("GTIN_8"));
    $this->assertEquals(GtinFormat::GTIN_12(), GtinFormat::valueOf("GTIN_12"));
    $this->assertEquals(GtinFormat::GTIN_13(), GtinFormat::valueOf("GTIN_13"));
    $this->assertEquals(GtinFormat::GTIN_14(), GtinFormat::valueOf("GTIN_14"));
  }

  /**
   * @expectedException InvalidArgumentException
   */
  public function /*void*/ testValueOfUnknownValueShouldThrowException() {
    GtinFormat::valueOf("GTIN_15");
  }

  public function /*void*/ testToStringShouldReturnReadableNames() {
    $this->assertEquals("GTIN-8", (string) GtinFormat::GTIN_8());
    $this->assertEquals("GTIN-12", (string) GtinFormat::GTIN_12());
    $this->assertEquals("GTIN-13", (string) GtinFormat::GTIN_13());
    $this->assertEquals("GTIN-14", (string) GtinFormat::GTIN_14());
  }

}
