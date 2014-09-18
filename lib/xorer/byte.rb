require 'xorer/char'
require 'xorer/binary_string'

module Xorer
  class Byte
    def initialize(byte)
      @byte = byte
    end

    def ==(other)
      byte == other || byte == other.byte
    end

    def to_s
      byte.to_s
    end

    def to_byte
      self
    end

    def to_char
      Char.new(byte.chr)
    end

    def to_binary_string
      BinaryString.new(byte.to_s 2)
    end

    attr_reader :byte
  end
end
