module Xorer
  class Token
    attr_reader :token

    def initialize(token)
      @token = token
    end

    def ==(other)
      if other.respond_to? :token
        token == other.token
      else
        token == other
      end
    end

    def to_s
      token.to_s
    end

    def to_binary_string
      fail 'Subclasses must implement this'
    end

    def xor(other)
      to_binary_string.xor(other.to_binary_string)
    end
  end
end
