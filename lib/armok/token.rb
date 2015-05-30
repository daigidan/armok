module Armok
  class Token
    attr_accessor :key, :values

    def initialize(s='')
      @key = ''
      @values = Array.new
      parse(s) unless s.empty?
    end

    def parse(s)
      @values = s.split(COLON)
      @key = @values.shift
    end

    def to_s
      '[' + [@key, @values].join(COLON) + ']'
    end

  end
end
