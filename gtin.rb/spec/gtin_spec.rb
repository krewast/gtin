require "gtin"

describe Gtin::Gtin do

  describe "#is_valid" do
    it "string of 7 digits should not be valid" do
      digits7 = "0123456"

      expect(Gtin::Gtin.valid?(digits7)).to be false
    end

    it "gtin8 should be valid" do
      gtin8 = "73513537"

      expect(Gtin::Gtin.valid?(gtin8)).to be true
    end

    it "string of 8 letters should not be valid" do
      letters8 = "abcdefgh"

      expect(Gtin::Gtin.valid?(letters8)).to be false
    end

    it "gtin8 with invalid check digit should not be valid" do
      bad_gtin8 = "73513536"

      expect(Gtin::Gtin.valid?(bad_gtin8)).to be false
    end

    it "gtin12 should be valid" do
      gtin12 = "123456789012"

      expect(Gtin::Gtin.valid?(gtin12)).to be true
    end

    it "gtin12 with invalid check digit should not be valid" do
      bad_gtin12 = "123456789010"

      expect(Gtin::Gtin.valid?(bad_gtin12)).to be false
    end

    it "gtin13 should be valid" do
      gtin13 = "4006381333931"

      expect(Gtin::Gtin.valid?(gtin13)).to be true
    end

    it "gtin13 with invalid check digit should not be valid" do
      bad_gtin13 = "4006381333932"

      expect(Gtin::Gtin.valid?(bad_gtin13)).to be false
    end

    it "gtin14 should be valid" do
      gtin14 = "10614141000415"

      expect(Gtin::Gtin.valid?(gtin14)).to be true
    end

    it "gtin14 with invalid check digit should not be valid" do
      bad_gtin14 = "10614141000416"

      expect(Gtin::Gtin.valid?(bad_gtin14)).to be false
    end

    it "validate nil should throw exception" do
      expect{Gtin::Gtin.valid?(nil)}.to raise_error(ArgumentError)
    end
  end

  describe "#is_valid8" do
    it "gtin8 should be valid8" do
      gtin8 = "03485736"

      expect(Gtin::Gtin.valid8?(gtin8)).to be true
    end

    it "gtin14 should not be valid8" do
      gtin14 = "34957354738950"

      expect(Gtin::Gtin.valid8?(gtin14)).to be false
    end
  end

  describe "#is_valid12" do
    it "gtin12 should be valid12" do
      gtin12 = "734092309436"

      expect(Gtin::Gtin.valid12?(gtin12)).to be true
    end
  end

  describe "#is_valid13" do
    it "gtin13 should be valid13" do
      gtin13 = "0234248273487"

      expect(Gtin::Gtin.valid13?(gtin13)).to be true
    end
  end

  describe "#is_valid14" do
    it "gtin14 should be valid14" do
      gtin14 = "34957354738950"

      expect(Gtin::Gtin.valid14?(gtin14)).to be true
    end

    it "gtin13 should not be valid14" do
      gtin13 = "0234248273487"

      expect(Gtin::Gtin.valid14?(gtin13)).to be false
    end
  end

  describe "#matches_format?" do
    it "string of 7 digits should not match format" do
      digits7 = "0123456"

      expect(Gtin::Gtin.matches_format?(digits7)).to be false
    end

    it "string of 8 digits should match format" do
      digits8 = "01234567"

      expect(Gtin::Gtin.matches_format?(digits8)).to be true
    end

    it "string of 8 letters should not match format" do
      letters8 = "abcdefgh"

      expect(Gtin::Gtin.matches_format?(letters8)).to be false
    end

    it "string of 8 letters and digits should not match format" do
      letters_and_digits8 = "0a1b2c3d"

      expect(Gtin::Gtin.matches_format?(letters_and_digits8)).to be false
    end

    it "string of 9 digits should not match format" do
      digits9 = "012345678"

      expect(Gtin::Gtin.matches_format?(digits9)).to be false
    end

    it "string of 11 digits should not match format" do
      digits11 = "01234567890"

      expect(Gtin::Gtin.matches_format?(digits11)).to be false
    end

    it "string of 12 digits should match format" do
      digits12 = "012345678901"

      expect(Gtin::Gtin.matches_format?(digits12)).to be true
    end

    it "string of 12 letters should not match format" do
      letters12 = "abcdefghijkl"

      expect(Gtin::Gtin.matches_format?(letters12)).to be false
    end

    it "string of 12 letters and digits should not match format" do
      letters_and_digits12 = "0a1b2c3d4e5f6g"

      expect(Gtin::Gtin.matches_format?(letters_and_digits12)).to be false
    end

    it "string of 13 digits should match format" do
      digits13 = "0123456789012"

      expect(Gtin::Gtin.matches_format?(digits13)).to be true
    end

    it "string of 13 letters should not match format" do
      letters13 = "abcdefghijklm"

      expect(Gtin::Gtin.matches_format?(letters13)).to be false
    end

    it "string of 13 letters and digits should not match format" do
      String letters_and_digits13 = "0a1b2c3d4e5f6g7"

      expect(Gtin::Gtin.matches_format?(letters_and_digits13)).to be false
    end

    it "string of 14 digits should match format" do
      String digits14 = "01234567890123"

      expect(Gtin::Gtin.matches_format?(digits14)).to be true
    end

    it "string of 14 letters should not match format" do
      String letters14 = "abcdefghijklmn"

      expect(Gtin::Gtin.matches_format?(letters14)).to be false
    end

    it "string of 14 letters and digits should not match format" do
      letters_and_digits14 = "0a1b2c3d4e5f6g7h"

      expect(Gtin::Gtin.matches_format?(letters_and_digits14)).to be false
    end

    it "string of 15 digits should not match format" do
      digits15 = "012345678901234"

      expect(Gtin::Gtin.matches_format?(digits15)).to be false
    end

    it "string of 14 digits should match specific Gtin format" do
      digits14 = "01234567890123"

      expect(Gtin::Gtin.matches_format?(digits14, Gtin::GtinFormat::GTIN_14)).to be true
    end
  end

  describe "#matches_format8?" do
    it "string of 8 digits should match format8" do
      digits8 = "01234567"

      expect(Gtin::Gtin.matches_format8?(digits8)).to be true
    end
  end

  describe "#matches_format12?" do
    it "string of 12 digits should match format12" do
      digits12 = "012345678901"

      expect(Gtin::Gtin.matches_format12?(digits12)).to be true
    end

    it "string of 8 digits should not match format12" do
      digits8 = "01234567"

      expect(Gtin::Gtin.matches_format12?(digits8)).to be false
    end
  end

  describe "#matches_format13?" do
    it "string of 13 digits should match format13" do
      digits13 = "0123456789012"

      expect(Gtin::Gtin.matches_format13?(digits13)).to be true
    end

    it "string of 12 digits should not match format13" do
      digits12 = "012345678901"

      expect(Gtin::Gtin.matches_format13?(digits12)).to be false
    end

    it "string of 14 digits should not match format13" do
      digits14 = "01234567890123"

      expect(Gtin::Gtin.matches_format13?(digits14)).to be false
    end
  end

  describe "#matches_format13?" do
    it "string of 14 digits should match format14" do
      digits14 = "01234567890123"

      expect(Gtin::Gtin.matches_format14?(digits14)).to be true
    end

    it "string of 13 digits should not match format14" do
      digits13 = "0123456789012"

      expect(Gtin::Gtin.matches_format14?(digits13)).to be false
    end
  end

  describe "#create" do
    it "gtin8 should parse to gtin" do
      gtin8 = "03485736"

      gtin = Gtin::Gtin.create(gtin8)

      expect(gtin.format).to eq(Gtin::GtinFormat::GTIN_8)
      expect(gtin.length).to eq(8)
      expect(gtin.to_s).to eq(gtin8)
    end

    it "gtin8 with invalid check digit should not parse to gtin" do
      bad_gtin8 = "73513536"

      expect{Gtin::Gtin.create(bad_gtin8)}.to raise_error(Gtin::GtinFormatError)
    end

    it "gtin12 should parse to gtin" do
      gtin12 = "734092309436"

      gtin = Gtin::Gtin.create(gtin12)

      expect(gtin.format).to eq(Gtin::GtinFormat::GTIN_12)
      expect(gtin.length).to eq(12)
      expect(gtin.to_s).to eq(gtin12)
    end

    it "gtin12 with invalid check digit should not parse to gtin" do
      bad_gtin12 = "123456789010"

      expect{Gtin::Gtin.create(bad_gtin12)}.to raise_error(Gtin::GtinFormatError)
    end

    it "gtin13 should parse to gtin" do
      gtin13 = "0234248273487"

      gtin = Gtin::Gtin.create(gtin13)

      expect(gtin.format).to eq(Gtin::GtinFormat::GTIN_13)
      expect(gtin.length).to eq(13)
      expect(gtin.to_s).to eq(gtin13)
    end

    it "gtin13 with invalid check digit should not parse to gtin" do
      bad_gtin13 = "4006381333932"

      expect{Gtin::Gtin.create(bad_gtin13)}.to raise_error(Gtin::GtinFormatError)
    end

    it "gtin14 should parse to gtin" do
      gtin14 = "10614141000415"

      gtin = Gtin::Gtin.create(gtin14)

      expect(gtin.format).to eq(Gtin::GtinFormat::GTIN_14)
      expect(gtin.length).to eq(14)
      expect(gtin.to_s).to eq(gtin14)
    end

    it "gtin14 with invalid check digit should not parse to gtin" do
      bad_gtin14 = "10614141000416"

      expect{Gtin::Gtin.create(bad_gtin14)}.to raise_error(Gtin::GtinFormatError)
    end

    it "create null should throw exception" do
      expect{Gtin::Gtin.create(nil)}.to raise_error(ArgumentError)
    end
  end

  describe "#eql?" do
    it "gtin should be equal to itself" do
      gtin14 = "10614141000415"
      gtin = Gtin::Gtin.create(gtin14)

      expect(gtin == gtin).to be true
    end

    it "same gtins should be equal" do
      gtin14 = "10614141000415"
      gtin1 = Gtin::Gtin.create(gtin14)
      gtin2 = Gtin::Gtin.create(gtin14)

      expect(gtin1 == gtin2).to be true
      expect(gtin2 == gtin1).to be true
    end

    it "different gtins should not be equal" do
      gtin13 = "0234248273487"
      gtin14 = "10614141000415"
      gtin1 = Gtin::Gtin.create(gtin14)
      gtin2 = Gtin::Gtin.create(gtin13)

      expect(gtin1 == gtin2).to be false
      expect(gtin2 == gtin1).to be false
    end

    it "gtin should not be equal to object of different type" do
      gtin14 = "10614141000415"
      gtin = Gtin::Gtin.create(gtin14)

      expect(gtin == gtin14).to be false
      expect(gtin == Object.new).to be false
    end
  end

  describe "#hash" do
    it "gtin hash code should be constant" do
      gtin14 = "10614141000415"
      gtin = Gtin::Gtin.create(gtin14)

      hash_code1 = gtin.hash
      hash_code2 = gtin.hash

      expect(hash_code1).to eq(hash_code2)
    end

    it "same gtins should have equal hash codes" do
      gtin14 = "10614141000415"
      gtin1 = Gtin::Gtin.create(gtin14)
      gtin2 = Gtin::Gtin.create(gtin14)

      expect(gtin1.hash).to eq(gtin2.hash)
    end

    it "different gtins should have unequal hash codes if possible" do
      gtin1 = Gtin::Gtin.create("10614141000415")
      gtin2 = Gtin::Gtin.create("34957354738950")

      expect(gtin1.hash).not_to eq(gtin2.hash)
    end
  end

  describe "#calculate_check_digit" do
    it "gtin8 calculated check digit should be correct" do
      partial_gtin8 = "7351353"

      check_digit = Gtin::Gtin.calculate_check_digit(partial_gtin8)

      expect(check_digit).to eq(7)
    end

    it "gtin12 calculated check digit should be correct" do
      partial_gtin12 = "73409230943"

      check_digit = Gtin::Gtin.calculate_check_digit(partial_gtin12)

      expect(check_digit).to eq(6)
    end

    it "gtin13 calculated check digit should be correct" do
      partial_gtin13 = "295248972349"

      check_digit = Gtin::Gtin.calculate_check_digit(partial_gtin13)

      expect(check_digit).to eq(0)
    end

    it "gtin14 calculated check digit should be correct" do
      partial_gtin14 = "1061414100041"

      check_digit = Gtin::Gtin.calculate_check_digit(partial_gtin14)

      expect(check_digit).to eq(5)
    end

    it "string of letters check digit should throw exception" do
      letters7 = "abcdefg"

      expect{Gtin::Gtin.calculate_check_digit(letters7)}.to raise_error(Gtin::GtinFormatError)
    end

    it "calculate check digit null should throw exception" do
      expect{Gtin::Gtin.calculate_check_digit(nil)}.to raise_error(ArgumentError)
    end
  end

  describe "#with_check_digit" do
    it "gtin8 with check digit should be correct" do
      partial_gtin8 = "7351353"

      gtin8 = Gtin::Gtin.with_check_digit(partial_gtin8)

      expect(gtin8).to eq("73513537")
    end

    it "string of letters with check digit should throw exception" do
      letters7 = "abcdefg"

      expect{Gtin::Gtin.with_check_digit(letters7)}.to raise_error(Gtin::GtinFormatError)
    end

    it "gtin12 with check digit should be correct" do
      partial_gtin12 = "73409230943"

      gtin12 = Gtin::Gtin.with_check_digit(partial_gtin12)

      expect(gtin12).to eq("734092309436")
    end

    it "gtin13 with check digit should be correct" do
      partial_gtin13 = "023424827348"

      gtin13 = Gtin::Gtin.with_check_digit(partial_gtin13)

      expect(gtin13).to eq("0234248273487")
    end

    it "gtin14 with check digit should be correct" do
      partial_gtin14 = "1061414100041"

      gtin14 = Gtin::Gtin.with_check_digit(partial_gtin14)

      expect(gtin14).to eq("10614141000415")
    end

    it "with null check digit should throw exception" do
      expect{Gtin::Gtin.with_check_digit(nil)}.to raise_error(ArgumentError)
    end
  end

  describe "#create_with_check_digit" do
    it "gtin14 create with check digit should be correct" do
      partial_gtin14 = "1061414100041"

      gtin14 = Gtin::Gtin.create_with_check_digit(partial_gtin14)

      expect(gtin14.to_s).to eq("10614141000415")
    end
    
    it "create with null check digit should throw exception" do
      expect{Gtin::Gtin.create_with_check_digit(nil)}.to raise_error(ArgumentError)
    end
  end

  describe "#check_digit" do
    it "gtin14 check digit should be correct" do
      gtin14 = "10614141000415"
      gtin = Gtin::Gtin.create(gtin14)

      expect(gtin.check_digit).to eq(5)
    end
  end

  describe "#digit_at" do
    it "gtin digit at should be correct" do
      gtin14 = "10614141000415"
      gtin = Gtin::Gtin.create(gtin14)

      expect(gtin.digit_at(0)).to eq(1)
      expect(gtin.digit_at(1)).to eq(0)
      expect(gtin.digit_at(2)).to eq(6)
      expect(gtin.digit_at(12)).to eq(1)
      expect(gtin.digit_at(13)).to eq(5)
    end
  end

end
