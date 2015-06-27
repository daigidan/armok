module Armok
  # A mixin for collections.
  module Collection
    include Enumerable

    def normalize(s)
      s.gsub(/\W/, '_').downcase
    end

    def symbolize(s)
      normalize(s).to_sym
    end

    def strip_invalid_utf8_bytes!(s)
      # force re-encoding to strip invalid UTF-8 bytes
      s.encode!('UTF-16', undef: :replace, invalid: :replace, replace: '')
      s.encode!('UTF-8')
    end

    def each
      @items.each { |item| yield item }
    end

    def index(&block)
      @items.index { |item| block.call(item)  }
    end

    def keys
      @items.map { |item| symbolize(item.key) }
    end

    def [](x)
      if x.is_a?(Symbol)
        x = @items.index { |item| symbolize(item.key) == x }
      elsif x.is_a?(String)
        x = @items.index { |item| item.key == x }
      end
      @items[x] if x
    end

    def []=(x, value)
      @items[x] = value
    end

    def length
      @items.length
    end

    def empty?
      @items.length == 0
    end
  end
end
