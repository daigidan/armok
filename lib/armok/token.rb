require 'armok/common'

module Armok
  # The name and values for each raw token.
  class Token
    attr_accessor :pre, :key, :values, :post

    def self.parse(s, pre, post)
      token = new(s)
      token.pre = pre
      token.post = post
      token
    end

    private_class_method :new

    def initialize(s)
      return if s.nil?
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
