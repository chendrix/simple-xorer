require 'xorer/byte'
require 'xorer/char'
require 'xorer/binary_string'
require 'xorer/token_list'
require 'xorer/key'
require 'xorer/input'

module Xorer
  def self.adjust_key_length(key_binary_array, input_binary_array)
    key_binary_array.adjusted_to_size_of(input_binary_array)
  end

  def self.binary_string_to_byte(binary_string)
    BinaryString.new(binary_string).to_byte
  end

  def self.byte_to_binary_string(byte)
    Byte.new(byte).to_binary_string
  end

  def self.byte_to_char(byte)
    Byte.new(byte).to_char
  end

  def self.string_to_binary_array(string)
    TokenList.from_string(string)
  end

  def self.char_to_byte(char)
    Char.new(char).to_byte
  end

  def self.largest_length(binary_strings)
    binary_strings.max_by(&:length).length
  end

  def self.pad_with_zeros(length, binary_string)
    BinaryString.new(binary_string).pad_with_zeros(length)
  end

  def self.run(key, input_file, output_file)
    key = Key.from_string(key)
    input_file = File.open(input_file, 'rb')
    input = Input.from_string(input_file)
    input_file.close

    self.write_xord_to_file(output_file, key, input)
  end

  def self.write_xord_to_file(output_file, key_binary_array, input_binary_array)
    File.open(output_file, 'wb') do |f|
      key_binary_array.xor(input_binary_array).each do |token|
        f.write token.to_char
      end
    end
  end

  def self.xor(val_1, val_2)
    BinaryString.new(val_1).xor(
      BinaryString.new(val_2)
    )
  end
end

