require 'armok/common'
require 'armok/token'

module Armok
  class Entity
    attr_accessor :id, :subtype, :tokens

    def initialize(id='', subtype='', s='')
      @id = id
      @subtype = subtype
      @tokens = Array.new
      parse(s) unless s.empty?
    end

    def parse(s)
      s.scan(TOKENS).each {|pre,s,post|
        @tokens << Token.new(s, pre, post)
      }
      self
    end

    def to_s
      "[#{subtype}:#{id}]#{tokens.join}"
    end

    def each
      @tokens.each {|token| yield token }
    end

    def [](i)
      @tokens[i]
    end

    def []=(i, value)
      @tokens[i] = value
    end

    def length
      @tokens.length
    end

    def empty?()
      @tokens.length == 0
    end

  end
end
