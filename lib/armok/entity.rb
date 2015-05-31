require 'armok/common'
require 'armok/collection'
require 'armok/token'

module Armok
  # Represents the definition of a creature, building, item, etc.
  class Entity
    include Collection
    attr_accessor :id, :subtype, :items

    def initialize(id = '', subtype = '', s = '')
      @id = id
      @subtype = subtype
      @items = []
      parse(s) unless s.empty?
    end

    def parse(s)
      s.scan(TOKENS).each do |pre, t, post|
        @items << Token.new(t, pre, post)
      end
      self
    end

    def to_s
      "[#{@subtype}:#{@id}]#{@items.join}"
    end
  end
end
