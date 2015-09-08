module Gtin
  #
  # Indicates an attempt to perform an operation on a string that is not a valid
  # Gtin.
  #
  class GtinFormatError < StandardError
  end
end
