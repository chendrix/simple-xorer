require 'xorer/token'
require 'xorer/byte'

module Xorer
  class BinaryString < Token
    def to_s
      "'#{binary_string.to_s}'"
    end

    def to_byte
      binary_array = binary_string.reverse.scan(/./).map { |i| i.to_i }
      count = 1
      sum = binary_array[0] * count
      1.upto(binary_array.size - 1) do |i|
        count *= 2
        sum += binary_array[i] * count
      end

      Byte.new(sum)
    end

    def to_char
      to_byte.to_char
    end

    def to_binary_string
      self
    end

    def xor(other)
      binary = pad_with_zeros(other.length)
      other_binary = other.pad_with_zeros(binary.length)

      integers = binary.binary_string.chars.map(&:to_i)
      other_integers = other_binary.binary_string.chars.map(&:to_i)

      xored_string = integers
          .zip(other_integers)
          .map do |elements|
            elements.first ^ elements.last
          end
          .join('')

      BinaryString.new(xored_string)
    end

    def length
      binary_string.length
    end

    def pad_with_zeros(length)
      BinaryString.new(binary_string.rjust(length, '0'))
    end

    def binary_string
      token
    end
  end
end
