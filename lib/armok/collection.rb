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

    def index(&block)
      @items.index { |item| block.call(item)  }
    end

    def normalize(s)
      s.gsub(/[^a-zA-Z0-9_]/, '_').downcase
    end

    def symbolize(s)
      normalize(s).to_sym
    end

    def keys
      @items.map { |item| symbolize(item.key) }
    end

    def [](i)
      if i.is_a?(Symbol)
        s = @items.index { |item| symbolize(item.key) == i }
        @items[s] if s
      elsif i.is_a?(String)
        s = @items.index { |item| item.key == i }
        @items[s] if s
      else
        @items[i]
      end
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
