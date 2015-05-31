require 'armok/common'
require 'armok/collection'
require 'armok/entities'

module Armok
  class File
    include Collection
    attr_accessor :filename, :name, :comment, :type, :items

    def initialize(s='')
      parse(s) unless s.empty?
    end

    def read(filename)
      puts filename
      @filename = filename
      parse(::IO.binread(filename))
    end

    def parse(s)
      # force re-encoding to strip invalid UTF-8 bytes
      s.encode!('UTF-16', :undef => :replace, :invalid => :replace, :replace => '')
      s.encode!('UTF-8')

      @name, @comment, @type, s = Match.new(s, FILE).captures
      @items = Entities.new(s)

      file = File.new
      file.filename,
      file.name,
      file.comment,
      file.type,
      file.items = self.filename, self.name, self.comment, self.type, self.items
      return file
    end

    def to_s
      "#{@name + @comment}[#{OBJECT + @type}]#{@items}"
    end

  end
end
