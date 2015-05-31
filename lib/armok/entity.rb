require 'armok/common'
require 'armok/collection'
require 'armok/token'

module Armok
  class Entity
    include Collection
    attr_accessor :id, :subtype, :items

    def initialize(id='', subtype='', s='')
      @id = id
      @subtype = subtype
      @items = Array.new
      parse(s) unless s.empty?
    end

    def parse(s)
      s.scan(TOKENS).each {|pre,s,post|
        @items << Token.new(s, pre, post)
      }
      self
    end

    def to_s
      "[#{@subtype}:#{@id}]#{@items.join}"
    end

  end
end
