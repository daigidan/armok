require 'armok/common'
require 'armok/collection'
require 'armok/file'

module Armok
  # Reads and parses an entire raw directory.
  class Dir
    include Collection
    attr_accessor :key, :items

    def self.read(dir)
      new(dir)
    end

    private_class_method :new

    def initialize(s)
      @items  = []
      @key = s
      return if s.nil?

      # break out of namespace on line below for core modules
      ::Dir.glob(::File.join(s, '*.txt')).each do |filename|
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
