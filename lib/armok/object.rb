require 'armok/common'
require 'armok/collection'
require 'armok/token'

module Armok
  # Represents the definition of a creature, building, item, etc.
  class Object
    include Collection
    attr_accessor :key, :subtype, :items

    def self.parse(s, key, subtype)
      object = new(s)
      object.key = key
      object.subtype = subtype
      object
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
      x = Match.capture(x.to_s, /^\w+_(\d+)$/).to_i if x.is_a?(Symbol)
      x = @items.index { |item| [item.key, item.values].join(COLON) == x } if x.is_a?(String)
      @items[x] if x
    end
  end
end
