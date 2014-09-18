require './lib/xorer'

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

  it 'adjusts the length of the key & input file to the same length' do
    key = 'mykey'
    input = "This is a test...\n"
    key_binary_array = Xorer.bytes_to_binary_array(key)
    input_binary_array = Xorer.bytes_to_binary_array(input)

    expected = ["1101101", "1111001", "1101011", "1100101", "1111001", "1101101", "1111001", "1101011", "1100101", "1111001", "1101101", "1111001", "1101011", "1100101", "1111001", "1101101", "1111001", "1101011"]

    expect(Xorer.adjust_key_length(key_binary_array, input_binary_array)).to eql(expected)
  end

  it 'returns the length of the largest array element' do
    input = "This is a test...\n"
    input_binary_array = Xorer.bytes_to_binary_array(input)
    expected = 7
    expect(Xorer.largest_length(input_binary_array)).to eql(expected)
  end

  it 'pads a binary string with zeros for the given length' do
    actual = "1010"
    expected = "00001010"
    expect(Xorer.pad_with_zeros(8, actual)).to eql(expected)
  end
end

