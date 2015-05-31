require 'armok/common'
require 'armok/file'

module Armok
  class Dir
    attr_accessor :dir, :files

    def initialize(dir='')
      @files  = Array.new
      read(dir) unless dir.empty?
    end

    def read(dir='')
      @dir = dir
      # break out of namespace below for core modules
      ::Dir.glob(::File.join(@dir, '*.txt')).each {|filename|
        begin
          @files << File.new.read(filename)
        rescue Armok::ParseError => e
          raise(Armok::ParseError, "#{filename}: #{e.message}")
        end
      }
      self
    end

    def each
      @files.each {|file| yield file }
    end

    def [](i)
      @files[i]
    end

    def []=(i, value)
      @files[i] = value
    end

    def length
      @files.length
    end

    def empty?()
      @files.length == 0
    end

  end
end
