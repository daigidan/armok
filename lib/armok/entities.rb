require 'armok/common'
require 'armok/collection'
require 'armok/entity'

module Armok
  # A collection of Entity definitions for any given subtype.
  class Entities
    include Collection
    attr_accessor :comment, :subtype, :items

    def self.parse(s)
      new(s)
    end

    private_class_method :new

    def initialize(s)
      @items = []
      return if s.nil?

      # sniff subtype for use as an entity delimeter
      @comment, @subtype = Match.capture(s, SUBTYPE)

      # find each entity's key
      s.scan(/#{LB}#{@subtype}:#{TAG}#{RB}/m).flatten.each do |key|
        next unless (tokens = find_tokens(key, s))
        @items << Entity.parse(tokens, key, @subtype)
      end
    end

    def to_s
      "#{@comment}#{@items.join}"
    end

    private

    def find_tokens(key, s)
      # find beginning of entity definition and split on it, after which
      # tokens[0] should hold stuff we don't care about (ie - either it's
      # whitespace from the beginning of the string or we've seen it already)
      # and tokens[1] should begin with the tokens we want.
      tokens = s.split(/#{subtype_re}#{key}#{RB}/)
      return if tokens.length < 2 || tokens[1].match(/\A\s*\Z/m)

      # now the string begins with the tokens we want, so we split
      # on the beginning of the next entity definition, after which
      # tokens[0] should hold just the tokens we want
      tokens = tokens[1].split(/#{subtype_re}/)
      tokens[0]
    end
  end
end
