require 'armok/common'

module Armok
  class Token
    attr_accessor :pre, :key, :values, :post

    def initialize(s='', pre='', post='')
      @pre, @post = pre, post
      parse(s) unless s.empty?
    end

    def parse(s)
      @values = s.split(COLON)
      @key = @values.shift
      self
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
