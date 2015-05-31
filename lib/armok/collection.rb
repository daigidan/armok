module Armok
  # A mixin for collections.
  module Collection
    def each
      @items.each { |item| yield item }
    end

    def map(&block)
      result = []
      each do |item|
        result << block.call(item)
      end
      result
    end

    def [](i)
      @items[i]
    end

    def []=(i, value)
      @items[i] = value
    end

    def length
      @items.length
    end

    def empty?
      @items.length == 0
    end
  end
end
