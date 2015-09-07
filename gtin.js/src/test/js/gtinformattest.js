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

QUnit.test("forLength7ShouldThrowException", function(assert) {
    assert.throws(function() { GTINFormat.forLength(7); }, RangeError);
});

QUnit.test("forLength8ShouldReturnGTIN_8", function(assert) {
    assert.ok(GTINFormat.GTIN_8 === GTINFormat.forLength(8));
});

QUnit.test("forLength9ShouldThrowException", function(assert) {
    assert.throws(function() { GTINFormat.forLength(9); }, RangeError);
});

QUnit.test("forLength11ShouldThrowException", function(assert) {
    assert.throws(function() { GTINFormat.forLength(11); }, RangeError);
});

QUnit.test("forLength12ShouldReturnGTIN_12", function(assert) {
    assert.ok(GTINFormat.GTIN_12 == GTINFormat.forLength(12));
});

QUnit.test("forLength13ShouldReturnGTIN_13", function(assert) {
    assert.ok(GTINFormat.GTIN_13 == GTINFormat.forLength(13));
});

QUnit.test("forLength14ShouldReturnGTIN_14", function(assert) {
    assert.ok(GTINFormat.GTIN_14 == GTINFormat.forLength(14));
});

QUnit.test("forLength15ShouldThrowException", function(assert) {
    assert.throws(function() { GTINFormat.forLength(15); }, RangeError);
});

QUnit.test("valueOf", function(assert) {
    assert.ok(GTINFormat.GTIN_8 == GTINFormat.valueOf("GTIN_8"));
    assert.ok(GTINFormat.GTIN_12 == GTINFormat.valueOf("GTIN_12"));
    assert.ok(GTINFormat.GTIN_13 == GTINFormat.valueOf("GTIN_13"));
    assert.ok(GTINFormat.GTIN_14 == GTINFormat.valueOf("GTIN_14"));
});

QUnit.test("valueOfUnknownValueShouldThrowException", function(assert) {
    assert.throws(function() { GTINFormat.valueOf("GTIN_15"); });
});

QUnit.test("toStringShouldReturnReadableNames", function(assert) {
    assert.ok("GTIN-8" == GTINFormat.GTIN_8.toString());
    assert.ok("GTIN-12" == GTINFormat.GTIN_12.toString());
    assert.ok("GTIN-13" == GTINFormat.GTIN_13.toString());
    assert.ok("GTIN-14" == GTINFormat.GTIN_14.toString());
});
