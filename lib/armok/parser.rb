$:.unshift File.join(File.dirname(__FILE__))
require 'citrus'
require 'parser_extensions'

module Armok
  class Parser
    include Extensions
    Citrus.require('grammar') # load grammar and its namespace

    def parse(s)
      Armok::Parser::Grammar.parse(s)
    end

    def parse_file(filename)
      Armok::Parser::Grammar.parse_file(filename)
    end
  end
end
