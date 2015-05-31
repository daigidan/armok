require 'armok/common'
require 'armok/dir'

module Armok
  class GodOfBlood
    attr_reader :dir, :files, :d

    def initialize(dir='')
      @files = Array.new
      @d = Hash.new
      shape(dir) unless dir.empty?
    end

    def shape(dir)
      @dir = Dir.new(dir)
    end

  end
end
