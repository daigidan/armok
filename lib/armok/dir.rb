require 'armok/common'
require 'armok/collection'
require 'armok/file'

module Armok
  # Reads and parses an entire raw directory.
  class Dir
    include Collection
    attr_accessor :key, :items

    def self.read(dir)
      Dir.new(dir)
    end

    def initialize(dir = '')
      @items  = []
      return if dir.empty?

      @key = dir
      # break out of namespace below for core modules
      ::Dir.glob(::File.join(dir, '*.txt')).each do |filename|
        begin
          @items << File.read(filename)
        rescue Armok::ParseError => e
          # prepend filename and pass the buck
          raise(Armok::ParseError, "#{filename}: #{e.message}")
        end
      end
    end
  end
end
