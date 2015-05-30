module Armok
  class Entity
    attr_accessor :id, :subtype, :tokens

    def initialize(id='', subtype='', s='')
      @id = id
      @subtype = subtype
      @tokens = Array.new
      parse(s) unless s.empty?
    end

    def parse(s)
      s.scan(/#{SPACE}#{LB}#{TOKEN}#{RB}#{SPACE}/m).each {|t|
        @tokens << Token.new(t[0])
      }
      self
    end

    def to_s
      "[#{subtype}:#{id}]#{NEWLINE}#{tokens.join(NEWLINE)}"
    end

  end
end
