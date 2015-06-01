require 'armok/common'

module Armok
  # The name and values for each raw token.
  class Token
    attr_accessor :pre, :key, :values, :post

    def self.parse(s, pre = '', post = '')
      Token.new(s, pre, post)
    end

    def initialize(s = '', pre = '', post = '')
      @pre = pre
      @post = post
      return if s.empty?

      @values = s.split(COLON)
      @key = @values.shift
    end

    def to_s
      if @values.empty?
        "#{@pre}[#{@key}]#{@post}"
      else
        "#{@pre}[#{[@key, @values].join(COLON)}]#{@post}"
      end
    end
  end
end
