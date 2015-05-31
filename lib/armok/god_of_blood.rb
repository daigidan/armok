require 'armok/common'
require 'armok/dir'

module Armok
  # The main interface for Armok, this class loads a directory
  # of raw files for manipulation.
  class GodOfBlood
    attr_reader :dir, :files, :d

    def initialize(dir = '')
      @files = []
      @d = {}
      shape(dir) unless dir.empty?
    end

    def shape(dir)
      @dir = Dir.new(dir)
    end
  end
end
