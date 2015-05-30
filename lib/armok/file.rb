module Armok
  class File
    attr_accessor :filename, :type, :entities

    def initialize(s='')
      parse(s) unless s.empty?
    end

    def parse(s)
      # force re-encoding to strip invalid UTF-8 bytes
      s.encode!('UTF-16', :undef => :replace, :invalid => :replace, :replace => '')
      s.encode!('UTF-8')

      @filename, @type, s = Match.new(s, /^#{FILENAME}#{TYPE}#{ENTITIES}$/m).captures
      @entities = Entities.new(s)

      file = File.new
      file.filename, file.type, file.entities = self.filename, self.type, self.entities
      return file
    end

    def to_s
      "#{@filename}#{BLANK_LINE}[OBJECT:#{@type}]#{BLANK_LINE}#{@entities.to_s}"
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
