$:.unshift File.join(File.dirname(__FILE__))
require 'citrus'
require 'parser_extensions'

module Armok
  class Parser
    include Extensions
    Citrus.require('dfraw') # load grammar and its namespace

    def parse(s)
      DFRaw.parse(s)
    end

    def parse_file(filename)
      DFRaw.parse_file(filename)
    end

  end
end
