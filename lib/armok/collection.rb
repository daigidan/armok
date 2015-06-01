module Armok
  # A mixin for collections.
  module Collection
    def normalize(s)
      s.gsub(/[^a-zA-Z0-9_]/, '_').downcase
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

    def keys
      @items.map { |item| symbolize(item.key) }
    end

    def [](x)
      if x.is_a?(Symbol)
        s = @items.index { |item| symbolize(item.key) == x }
        @items[s] if s
      elsif x.is_a?(String)
        s = @items.index { |item| item.key == x }
        @items[s] if s
      else
        @items[x]
      end
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
