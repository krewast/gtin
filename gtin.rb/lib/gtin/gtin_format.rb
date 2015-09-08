module Gtin
  #
  # Enumeration of the different GTIN formats.
  #
  class GtinFormat
    # Prevent public instantiation
    private_class_method :new

    def initialize(name, length)
      @name = name
      @length = length
    end

    #
    # GTIN-8, EAN-8. The short version of EAN-13 for extremely small products.
    #
    GTIN_8 = new('GTIN_8', 8)

    #
    # GTIN-12, UPC-A, UPC-12. Standard version of the UPC code.
    #
    GTIN_12 = new('GTIN_12', 12)

    #
    # GTIN-13, EAN-13. Primarily used in supermarkets to identify products at
    # the point of sales.
    #
    GTIN_13 = new('GTIN_13', 13)

    #
    # GTIN-14, EAN-14. Commonly used for traded goods.
    #
    GTIN_14 = new('GTIN_14', 14)

    #
    # @return an array of all of the GTINFormats.
    #
    def self.values
      [GTIN_8, GTIN_12, GTIN_13, GTIN_14]
    end

    #
    # Returns the enum constant of the specified enum type with the specified
    # name.
    #
    # @param the name of the constant to return.
    # @return the enum constant of the specified enum type with the specified
    # name.
    # @throws RangeError if the name does not match the name of any of the
    # known formats.
    #
    def self.value_of(name)
      GtinFormat.values.each do |gtin_format|
        return gtin_format if name == gtin_format.name
      end
      fail(RangeError, "Name '#{name}' does not match the name of any known "\
        'GTIN formats')
    end

    #
    # Gets the GTIN format for the specified length.
    #
    # @param gtin_length the length of the GTIN.
    # @return the GTINFormat for the given length.
    # @throws RangeError if the length does not match the length of any of the
    # known formats.
    #
    def self.for_length(gtin_length)
      GtinFormat.values.each do |gtin_format|
        return gtin_format if gtin_length == gtin_format.length
      end
      fail(RangeError, "Length '#{gtin_length}' does not match the length of "\
        'any known GTIN formats')
    end

    #
    # @return the name of the constant, e.g. GTIN_8.
    #
    attr_reader :name

    #
    # @return the length of this GTIN format.
    #
    attr_reader :length

    #
    # @return the name of the format, e.g. GTIN-12.
    #
    def to_s
      "GTIN-#{@length}"
    end

    def ==(other)
      self.equal?(other)
    end

    alias_method :eql?, :==

    def hash
      13 + @length
    end
  end
end
