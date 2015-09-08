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

/**
 * Indicates an attempt to perform an operation on a string that is not a valid Gtin.
 */
function GtinFormatError(message) {
    "use strict";
    var error = Error.apply(this, arguments);
    this.message = (message || null);
    this.name = error.name = "GtinFormatError";
    if (error.stack) {
        this.stack = error.stack.substring(error.stack.indexOf("\n") + 1);
    }
    this.toString = function() {
        return (message !== null) ? (name + ": " + message) : name;
    };
}

// Inherit from Error
GtinFormatError.prototype = Object.create(Error.prototype);
