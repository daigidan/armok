require 'armok/common'
require 'armok/collection'
require 'armok/entities'

module Armok
  # Represents a single raw file.
  class File
    include Collection
    attr_accessor :key, :comment, :type, :items

    def self.read(filename)
      File.new(::IO.binread(filename))
    end

    def self.strip_invalid_utf8_bytes!(s)
      # force re-encoding to strip invalid UTF-8 bytes
      s.encode!('UTF-16', undef: :replace, invalid: :replace, replace: '')
      s.encode!('UTF-8')
    end

    def self.parse(s)
      File.new(s)
    end

    def initialize(s = '')
      return if s.empty?
      File.strip_invalid_utf8_bytes!(s)
      @key, @comment, @type, s = Match.capture(s, FILE)
      @items = Entities.new(s)
    end

    def to_s
      "#{@key + @comment}[#{OBJECT + @type}]#{@items}"
    end
  end
end
