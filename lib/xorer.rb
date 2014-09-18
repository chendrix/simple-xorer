module Xorer
  def self.adjust_key_length(key_binary_array, input_binary_array)
    if key_binary_array.size != input_binary_array.size
      if key_binary_array.size < input_binary_array.size
        times = input_binary_array.size / key_binary_array.size
        key_binary_array *= times + 1
      end
      key_binary_array = key_binary_array[0...input_binary_array.size]
    end
  end

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

  def self.bytes_to_binary_array(bytes)
    bytes_binary_array = []
    bytes.each_byte do |b|
      bytes_binary_array << self.byte_to_binary_string(b)
    end
    bytes_binary_array
  end

  def self.char_to_byte(char)
    char.ord
  end

  def self.largest_length(binary_strings)
    largest = 0
    binary_strings.each do |string|
      largest = (largest > string.size) ? largest : string.size
    end
    largest
  end

  def self.pad_with_zeros(length, binary_string)
    if binary_string.size < length
      zeros = length - binary_string.size
      binary_string = (binary_string.reverse << ('0' * zeros)).reverse
    end
    binary_string
  end

  def self.run(key, input_file, output_file)
      key_binary_array = self.bytes_to_binary_array(key)
      input_file = File.open(input_file, 'rb')
      input_binary_array = self.bytes_to_binary_array(input_file)
      input_file.close

      key_binary_array = self.adjust_key_length(key_binary_array, input_binary_array)

      key_largest = self.largest_length(key_binary_array)
      input_largest = self.largest_length(input_binary_array)
      largest = (key_largest > input_largest) ? key_largest : input_largest

      key_binary_array.map! do |value|
        self.pad_with_zeros(largest, value)
      end

      input_binary_array.map! do |value|
        self.pad_with_zeros(largest, value)
      end

      self.write_xord_to_file(output_file, key_binary_array, input_binary_array)
  end

  def self.write_xord_to_file(output_file, key_binary_array, input_binary_array)
    File.open(output_file, 'wb') do |f|
      0.upto(input_binary_array.size - 1) do |idx|
        xord = xor(key_binary_array[idx], input_binary_array[idx])
        byte = self.binary_string_to_byte(xord)
        char = self.byte_to_char(byte)
        f.write char
      end
    end
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

