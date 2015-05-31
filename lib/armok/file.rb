require 'armok/common'
require 'armok/entities'
require 'pp'

module Armok
  class File
    attr_accessor :filename, :comment, :type, :entities

    def initialize(s='')
      parse(s) unless s.empty?
    end

    def read(filename)
      parse(::IO.binread(filename))
    end

    def parse(s)
      # force re-encoding to strip invalid UTF-8 bytes
      s.encode!('UTF-16', :undef => :replace, :invalid => :replace, :replace => '')
      s.encode!('UTF-8')

      @filename, @comment, @type, s = Match.new(s, FILE).captures
      @entities = Entities.new(s)

      file = File.new
      file.filename,
      file.comment,
      file.type,
      file.entities = self.filename, self.comment, self.type, self.entities
      return file
    end

    def to_s
      "#{@filename + @comment}[#{OBJECT + @type}]#{@entities}"
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

    def length
      @entities.length
    end

    def empty?()
      @entities.length == 0
    end

  end
end
