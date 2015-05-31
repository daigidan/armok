require 'armok/common'
require 'armok/collection'
require 'armok/entities'

module Armok
  class File
    include Collection
    attr_accessor :filename, :name, :comment, :type, :items

    def initialize(s='', filename='', name='', comment='', type='', items=nil)
      @filename = filename
      @name = name
      @comment = comment
      @type = type
      @items = items
      parse(s) unless s.empty?
    end

    def read(filename)
      @filename = filename
      parse(::IO.binread(filename))
    end

    def parse(s)
      strip_invalid_utf8_bytes(s)
      @name, @comment, @type, s = Match.new(s, FILE).captures
      @items = Entities.new(s)
      File.new('', @filename, @name, @comment, @type, @items)
    end

    def to_s
      "#{@name + @comment}[#{OBJECT + @type}]#{@items}"
    end

    def strip_invalid_utf8_bytes(s)
      # force re-encoding to strip invalid UTF-8 bytes
      s.encode!('UTF-16', :undef => :replace, :invalid => :replace, :replace => '')
      s.encode!('UTF-8')
    end

  end
end
