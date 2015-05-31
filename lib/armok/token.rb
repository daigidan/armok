require 'armok/common'

module Armok
  # The name and values for each raw token.
  class Token
    attr_accessor :pre, :key, :values, :post

    def initialize(s = '', pre = '', key = '', values = [], post = '')
      @pre = pre
      @post = post
      parse(s) unless s.empty?
    end

    def parse(s)
      @values = s.split(COLON)
      @key = @values.shift
      Token.new('', @pre, @key, @values, @post)
    end

    def to_s
      if @values.empty?
        "#{pre}[#{key}]#{post}"
      else
        "#{pre}[#{[@key, @values].join(COLON)}]#{post}"
      end
    end
  end
end
