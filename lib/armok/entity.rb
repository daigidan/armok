require 'armok/common'
require 'armok/collection'
require 'armok/token'

module Armok
  # Represents the definition of a creature, building, item, etc.
  class Entity
    include Collection
    attr_accessor :key, :subtype, :items

    def self.parse(s, key, subtype)
      entity = new(s)
      entity.key = key
      entity.subtype = subtype
      entity
    end

    private_class_method :new

    def initialize(s)
      @items = []
      return if s.nil?

      s.scan(TOKENS).each do |pre, t, post|
        @items << Token.parse(t, pre, post)
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
