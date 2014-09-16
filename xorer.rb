module Xorer
  def self.binary_string_to_byte(binary_string)
    binary_array = binary_string.reverse.scan(/./).map { |i| i.to_i }
    count = 1
    sum = binary_array[0] * count
    1.upto(binary_array.size - 1) do |i|
      count *= 2
      sum += binary_array[i] * count
    end
    sum
  end

  def self.byte_to_binary_string(byte)
    byte.to_s 2
  end

  def self.byte_to_char(byte)
    byte.chr
  end

  def self.char_to_byte(char)
    char.ord
  end

  def self.xor(val_1, val_2)
    val_1 = val_1.to_s.scan(/./).map { |i| i.to_i }
    val_2 = val_2.to_s.scan(/./).map { |i| i.to_i }
    xord = []
    0.upto(val_1.size - 1) do |i|
      xord << (val_1[i] ^ val_2[i])
    end
    xord.join('')
  end
end

describe Xorer do
  it 'converts a character to a byte' do
    expect(Xorer.char_to_byte('a')).to be(97)
  end

  it 'converts a byte to a binary string' do
    expect(Xorer.byte_to_binary_string(97)).to eql('1100001')
  end

  it 'xors two binary values' do
    expect(Xorer.xor(0, 0)).to eql('0')
  end

  it 'xors two binary strings' do
    expect(Xorer.xor('1100001', '1100010')).to eql('0000011')
  end

  it 'converts a binary string to a byte' do
    expect(Xorer.binary_string_to_byte('1100001')).to eql(97)
  end

  it 'converts a byte to a character' do
    expect(Xorer.byte_to_char(97)).to eql('a')
  end
end
