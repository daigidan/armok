require 'armok/common'
require 'armok/collection'
require 'armok/entities'

module Armok
  # Represents a single raw file.
  class File
    include Collection
    attr_accessor :key, :comment, :type, :items

    def self.read(filename)
      new(::IO.binread(filename))
    end

    def self.parse(s)
      new(s)
    end

    private_class_method :new

    def initialize(s)
      return if s.nil?
      strip_invalid_utf8_bytes!(s)
      @key, @comment, @type, s = Match.capture(s, FILE)
      @items = Entities.parse(s)
    end

    def to_s
      "#{@key + @comment}[#{OBJECT + @type}]#{@items}"
    end
  end
end
