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
 * Indicates an attempt to perform an operation on a string that is not a valid GTIN.
 */
class GtinFormatException extends \InvalidArgumentException {

  /**
   * Constructs a new {@code GtinFormatException} with the specified detail message. The
   * cause is not initialized, and may subsequently be initialized by a call to {@link #initCause}.
   *
   * @param message the detail message.
   */
  public function __construct(/*string*/ $message) {
    parent::__construct($message, 0, null);
  }

}
