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

/**
 * Indicates an attempt to parse an invalid string to a GTIN.
 */
public class InvalidGTINException extends RuntimeException {

    /**
     * Constructs a new {@code InvalidGTINException} with the specified detail message. The
     * cause is not initialized, and may subsequently be initialized by a call to {@link #initCause}.
     *
     * @param message the detail message.
     */
    public InvalidGTINException(final String message) {
        super(message);
    }

}
