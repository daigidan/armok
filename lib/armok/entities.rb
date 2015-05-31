require 'armok/common'
require 'armok/entity'

module Armok
  class Entities
    attr_accessor :entities, :subtype, :comment

    def initialize(s='')
      @entities = Array.new
      parse(s) unless s.empty?
    end

    def parse(s)
      # sniff subtype for use as an entity delimeter
      @comment, @subtype = Match.new(s, SUBTYPE).captures
      subtype_re = "#{LB}#{@subtype}:"

      # find each entity's id
      s.scan(/#{subtype_re}#{TAG}#{RB}/m).flatten.each {|id|
        # find beginning of entity definition and split on it, after which
        # tokens[0] should hold stuff we don't care about (ie - either it's
        # whitespace from the beginning of the string or we've seen it already)
        # and tokens[1] should begin with the tokens we want.
        tokens = s.split(/#{subtype_re}#{id}#{RB}/)
        next if tokens.length < 2 or tokens[1].match(/\A\s*\Z/m) # skip whitespace

        # now the string begins with the tokens we want, so we split
        # on the beginning of the next entity definition, after which
        # tokens[0] should hold just the tokens we want
        tokens = tokens[1].split(/#{subtype_re}/)

        # these are the droids we're looking for
        @entities << Entity.new(id, @subtype, tokens[0])
      }
      self
    end

    def to_s
      "#{@comment}#{@entities.join}"
    end

    def each
      @entities.each {|entity| yield entity }
    end

    def [](i)
      @entities[i]
    end

    def []=(i, value)
      @entities[i] = value
    end

    def <<(i)
      @entities << i
    end

    def +(i)
      @entities << i
    end

    def length
      @entities.length
    end

    def empty?()
      @entities.length == 0
    end

  end
end
