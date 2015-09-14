require 'gtin/version'
require 'gtin/gtin_format'
require 'gtin/gtin_format_error'

module Gtin
  #
  # Valid GTIN code. Static methods are provided for identifying, validating and
  # parsing GTIN codes represented as strings.
  #
  class Gtin
    # Prevent public instantiation
    private_class_method :new

    def initialize(gtin)
      @gtin = gtin
      @format = GtinFormat.for_length(gtin.length)
    end

    #
    # Creates a GTIN from the given string.
    # You may use the {@link #isValid(String)} method first if you are unsure
    # whether the string is a valid GTIN to avoid a GtinFormatException being
    # thrown.
    #
    # @param gtin the GTIN string.
    # @return a GTIN object if the string is a valid GTIN.
    # @throws GtinFormatError if the string is not a valid GTIN.
    #
    def self.create(gtin)
      unless valid?(gtin)
        fail(GtinFormatError, "String '" + gtin + "' is not a valid gtin")
      end
      new(gtin)
    end

    #
    # Creates a GTIN from the given partial GTIN string without the check digit.
    #
    # @param gtin_without_check_digit the GTIN without the final check digit.
    # @return a GTIN object if the string is a valid GTIN.
    # @throws GtinFormatError if the string is not a valid partial GTIN.
    #
    def self.create_with_check_digit(gtin_without_check_digit)
      new(with_check_digit(gtin_without_check_digit))
    end

    #
    # Checks if the string is a valid specific GTIN format by checking the
    # format, length and checksum.
    #
    # @param gtin the GTIN string to check, may be GTIN-8, GTIN-12, GTIN-13 or
    # GTIN-14 format.
    # @param format optional, the GTIN format to check the string against, if
    # not specified accepts any format.
    # @return {@code true} if the GTIN is valid, {@code false} otherwise.
    #
    def self.valid?(gtin, format = nil)
      # Check format of barcode for validity
      return false unless matches_format?(gtin)
      gtin_length = gtin.length
      return false if !format.nil? && gtin_length != format.length
      checksum = 0
      weight_bit = gtin_length % 2
      gtin_length.times do |i|
        weight = i % 2 == weight_bit ? 3 : 1
        checksum += gtin[i].to_i * weight
      end
      checksum % 10 == 0
    end

    #
    # Checks if the string is a valid GTIN-8 by checking the format and
    # checksum.
    #
    # @param gtin the GTIN-8 string to check.
    # @return {@code true} if the GTIN is valid, {@code false} otherwise.
    #
    def self.valid8?(gtin)
      valid?(gtin, GtinFormat::GTIN_8)
    end

    #
    # Checks if the string is a valid GTIN-12 by checking the format and
    # checksum.
    #
    # @param gtin the GTIN-12 string to check.
    # @return {@code true} if the GTIN is valid, {@code false} otherwise.
    #
    def self.valid12?(gtin)
      valid?(gtin, GtinFormat::GTIN_12)
    end

    #
    # Checks if the string is a valid GTIN-13 by checking the format and
    # checksum.
    #
    # @param gtin the GTIN-13 string to check.
    # @return {@code true} if the GTIN is valid, {@code false} otherwise.
    #
    def self.valid13?(gtin)
      valid?(gtin, GtinFormat::GTIN_13)
    end

    #
    # Checks if the string is a valid GTIN-14 by checking the format and
    # checksum.
    #
    # @param gtin the GTIN-14 string to check.
    # @return {@code true} if the GTIN is valid, {@code false} otherwise.
    #
    def self.valid14?(gtin)
      valid?(gtin, GtinFormat::GTIN_14)
    end

    #
    # Calculates the check digit for a partial GTIN.
    #
    # @param gtin_without_check_digit the GTIN without the final check digit.
    # @return the check digit to complete the GTIN code.
    # @throws GtinFormatError if the string is not a valid partial GTIN without
    # the check digit.
    #
    def self.calculate_check_digit(gtin_without_check_digit)
      unless matches_format?(gtin_without_check_digit, nil, 1)
        fail(GtinFormatError, "String '#{gtin_without_check_digit}' is not a "\
          'valid partial gtin')
      end
      checksum = 0
      gtin_length = gtin_without_check_digit.length
      weight_bit = (gtin_length + 1) % 2
      gtin_length.times do |i|
        weight = i % 2 == weight_bit ? 3 : 1
        checksum += gtin_without_check_digit[i].to_i * weight
      end
      checksum % 10 == 0 ? 0 : 10 - (checksum % 10)
    end

    #
    # Returns the given partial GTIN code with check digit added.
    #
    # @param gtin_without_check_digit the GTIN without the final check digit.
    # @return the GTIN code with check digit.
    # @throws GtinFormatError if the string is not a valid partial GTIN without
    # the check digit.
    #
    def self.with_check_digit(gtin_without_check_digit)
      gtin_without_check_digit + \
        calculate_check_digit(gtin_without_check_digit).to_s
    end

    #
    # Checks whether the input string matches the GTIN format, i.e. is
    # of the correct length that format GTIN and that the string contains only
    # digits.
    #
    # @param gtin the possible GTIN string.
    # @param format optional, the GTIN format to check the string against.
    # @param offset optional, the number of characters missing from the full
    # GTIN string.
    # @return {@code true} if the input string is a valid GTIN string,
    # {@code false} otherwise.
    #
    def self.matches_format?(gtin, format = nil, offset = 0)
      fail(ArgumentError, 'gtin is nil') if gtin.nil?
      # Check length
      gtin_length = gtin.length
      valid_length = false
      if !format.nil?
        valid_length = gtin_length == format.length
      else
        GtinFormat.values.each do |gtin_format|
          if gtin_length == gtin_format.length - offset
            valid_length = true
            break
          end
        end
      end
      return false unless valid_length
      # Check whether is a number
      !gtin.match(/^[0-9]+$/).nil?
    end

    #
    # Checks whether the input string matches the GTIN-8 format, i.e. is of the
    # correct length and that the string contains only digits.
    #
    # @param gtin the possible GTIN string.
    # @return {@code true} if the input string is a valid GTIN string,
    # {@code false} otherwise.
    #
    def self.matches_format8?(gtin)
      matches_format?(gtin, GtinFormat::GTIN_8, 0)
    end

    #
    # Checks whether the input string matches the GTIN-12 format, i.e. is of the
    # correct length and that the string contains only digits.
    #
    # @param gtin the possible GTIN string.
    # @return {@code true} if the input string is a valid GTIN string,
    # {@code false} otherwise.
    #
    def self.matches_format12?(gtin)
      matches_format?(gtin, GtinFormat::GTIN_12, 0)
    end

    #
    # Checks whether the input string matches the GTIN-13 format, i.e. is of the
    # correct length and that the string contains only digits.
    #
    # @param gtin the possible GTIN string.
    # @return {@code true} if the input string is a valid GTIN string,
    # {@code false} otherwise.
    #
    def self.matches_format13?(gtin)
      matches_format?(gtin, GtinFormat::GTIN_13, 0)
    end

    #
    # Checks whether the input string matches the GTIN-14 format, i.e. is of the
    # correct length and that the string contains only digits.
    #
    # @param gtin the possible GTIN string.
    # @return {@code true} if the input string is a valid GTIN string,
    # {@code false} otherwise.
    #
    def self.matches_format14?(gtin)
      matches_format?(gtin, GtinFormat::GTIN_14, 0)
    end

    #
    # @return the format or type of this GTIN.
    #
    attr_reader :format

    #
    # @return the length of this GTIN.
    #
    def length
      @format.length
    end

    #
    # @return the check digit of this GTIN.
    #
    def check_digit
      @gtin[-1].to_i
    end

    #
    # Gets the digit at the specified position.
    #
    # @param position the position, from 0 to length - 1.
    # @return the digit at the specified position.
    #
    def digit_at(position)
      @gtin[position].to_i
    end

    #
    # @return this GTIN code as a string.
    #
    def to_s
      @gtin
    end

    def ==(other)
      self.equal?(other) || other.instance_of?(Gtin) && @gtin == other.to_s
    end

    alias_method :eql?, :==

    def hash
      37 + @gtin.hash
    end
  end
end
