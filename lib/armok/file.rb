require 'armok/common'
require 'armok/collection'
require 'armok/entities'

module Armok
  # Represents a single raw file.
  class File
    include Collection
    attr_accessor :filename, :name, :comment, :type, :items

    def initialize(s = '', clone = {})
      unless clone.empty?
        @filename = clone[:filename]
        @name = clone[:name]
        @comment = clone[:comment]
        @type = clone[:type]
        @items = clone[:items]
      end
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
      File.new('',
        filename: @filename,
        name:     @name,
        comment:  @comment,
        type:     @type,
        items:    @items
      )
    end

    def to_s
      "#{@name + @comment}[#{OBJECT + @type}]#{@items}"
    end

    def strip_invalid_utf8_bytes(s)
      # force re-encoding to strip invalid UTF-8 bytes
      s.encode!('UTF-16', undef: :replace, invalid: :replace, replace: '')
      s.encode!('UTF-8')
    end
  end
end
