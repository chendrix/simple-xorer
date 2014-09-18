require 'xorer/binary_string'

module Xorer
  class TokenList
    include Enumerable

    def initialize(token_list)
      @token_list = token_list
    end

    def self.from_string(string)
      binary_string_array = string.chars.map { |char| Char.new(char).to_binary_string }
      new(binary_string_array)
    end

    def ==(other)
      token_list == other || token_list == other.token_list
    end

    def to_s
      "[#{token_list.map(&:to_s).join(', ')}]"
    end

    def size
      token_list.size
    end

    def adjusted_to_size_of(other_token_list)
      token_list = self.token_list

      if size != other_token_list.size
        if size < other_token_list.size
          times = other_token_list.size / size
          token_list *= times + 1
        end
        TokenList.new(token_list[0...other_token_list.size])
      else
        self
      end
    end

    def xor(other)
      list = adjusted_to_size_of(other)
      other_list = other.adjusted_to_size_of(list)

      xored_list = list.token_list
        .zip(other_list.token_list)
        .map do |tokens|
          tokens.first.xor(tokens.last)
        end

      TokenList.new(xored_list)
    end

    def each(&block)
      token_list.each(&block)
    end

    attr_reader :token_list
  end
end
