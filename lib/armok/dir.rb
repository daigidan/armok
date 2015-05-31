require 'armok/common'
require 'armok/collection'
require 'armok/file'

module Armok
  # Reads and parses an entire raw directory.
  class Dir
    include Collection
    attr_accessor :dir, :items

    def initialize(dir = '')
      @items  = []
      read(dir) unless dir.empty?
    end

    def read(dir = '')
      @dir = dir
      # break out of namespace below for core modules
      ::Dir.glob(::File.join(@dir, '*.txt')).each do |filename|
        begin
          @items << File.new.read(filename)
        rescue Armok::ParseError => e
          # prepend filename and pass the buck
          raise(Armok::ParseError, "#{filename}: #{e.message}")
        end
      end
      self
    end
  end
end
