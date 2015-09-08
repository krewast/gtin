require "gtin/gtin_format"

describe Gtin::GtinFormat do

  describe "#for_length" do
    it "7 should throw exception" do
      expect{Gtin::GtinFormat.for_length(7)}.to raise_error(RangeError)
    end

    it "8 should return Gtin8" do
      expect(Gtin::GtinFormat.for_length(8)).to eq(Gtin::GtinFormat::GTIN_8)
    end

    it "9 should throw exception" do
      expect{Gtin::GtinFormat.for_length(9)}.to raise_error(RangeError)
    end

    it "11 should throw exception" do
      expect{Gtin::GtinFormat.for_length(11)}.to raise_error(RangeError)
    end

    it "12 should return Gtin12" do
      expect(Gtin::GtinFormat.for_length(12)).to eq(Gtin::GtinFormat::GTIN_12)
    end

    it "13 should return Gtin13" do
      expect(Gtin::GtinFormat.for_length(13)).to eq(Gtin::GtinFormat::GTIN_13)
    end

    it "14 should return Gtin14" do
      expect(Gtin::GtinFormat.for_length(14)).to eq(Gtin::GtinFormat::GTIN_14)
    end

    it "15 should throw exception" do
      expect{Gtin::GtinFormat.for_length(15)}.to raise_error(RangeError)
    end
  end

  describe "#value_of" do
    it "should return correct value" do
      expect(Gtin::GtinFormat.value_of("GTIN_8")).to eq(Gtin::GtinFormat::GTIN_8)
      expect(Gtin::GtinFormat.value_of("GTIN_12")).to eq(Gtin::GtinFormat::GTIN_12)
      expect(Gtin::GtinFormat.value_of("GTIN_13")).to eq(Gtin::GtinFormat::GTIN_13)
      expect(Gtin::GtinFormat.value_of("GTIN_14")).to eq(Gtin::GtinFormat::GTIN_14)
    end

    it "should throw exception" do
      expect{Gtin::GtinFormat.value_of("GTIN_15")}.to raise_error(RangeError)
    end
  end

  describe "#to_s" do
    it "should return readable names" do
      expect(Gtin::GtinFormat::GTIN_8.to_s).to eq("GTIN-8")
      expect(Gtin::GtinFormat::GTIN_12.to_s).to eq("GTIN-12")
      expect(Gtin::GtinFormat::GTIN_13.to_s).to eq("GTIN-13")
      expect(Gtin::GtinFormat::GTIN_14.to_s).to eq("GTIN-14")
    end
  end

  describe "#hash" do
    it "should return constant value" do
      hash1 = Gtin::GtinFormat::GTIN_8.hash
      hash2 = Gtin::GtinFormat::GTIN_8.hash

      expect(hash1).to eq(hash2)
    end

    it "should return different value for all enum values" do
      hash8 = Gtin::GtinFormat::GTIN_8.hash
      hash12 = Gtin::GtinFormat::GTIN_12.hash
      hash13 = Gtin::GtinFormat::GTIN_13.hash
      hash14 = Gtin::GtinFormat::GTIN_14.hash

      expect(hash8).not_to eq(hash12)
      expect(hash8).not_to eq(hash13)
      expect(hash8).not_to eq(hash14)

      expect(hash12).not_to eq(hash13)
      expect(hash12).not_to eq(hash14)

      expect(hash13).not_to eq(hash14)
    end
  end

end
