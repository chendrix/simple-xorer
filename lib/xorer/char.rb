require 'xorer/byte'

module Xorer
  class Char
    def initialize(char)
      @char = char
    end

    def ==(other)
      char == other || char == other.char
    end

    def to_s
      char.to_s
    end

    def to_byte
      Byte.new(char.ord)
    end

    def to_char
      self
    end

    def to_binary_string
      to_byte.to_binary_string
    end

    private

    attr_reader :char
  end
end
