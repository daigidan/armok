require 'armok/common'
require 'armok/collection'
require 'armok/token'

module Armok
  # Represents the definition of a creature, building, item, etc.
  class Entity
    include Collection
    attr_accessor :key, :subtype, :items

    def self.parse(s)
      Entity.new(s)
    end

    def initialize(key = '', subtype = '', s = '')
      @key = key
      @subtype = subtype
      @items = []
      return if s.empty?

      s.scan(TOKENS).each do |pre, t, post|
        @items << Token.new(t, pre, post)
      end
    end

    def to_s
      "[#{@subtype}:#{@key}]#{@items.join}"
    end

    def keys
      @items.each_with_index.map { |item, i| symbolize(item.key + "_#{i}") }
    end

    def [](x)
      if x.is_a?(Symbol)
        index = Match.capture(x.to_s, /^\w+_(\d+)$/)
        @items[index.to_i]
      elsif x.is_a?(String)
        @items[@items.index { |item| [item.key, item.values].join(COLON) == x }]
      else
        @items[x]
      end
    end
  end
end
