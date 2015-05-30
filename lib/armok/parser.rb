$:.unshift File.join(File.dirname(__FILE__))
require 'citrus'
require 'parser_extensions'

module Armok
  class Parser
    include Extensions
    Citrus.require('grammar/file') # load grammar and its namespace

    def parse(s)
      # force re-encoding to strip invalid UTF-8 bytes
      s.encode!('UTF-16', :undef => :replace, :invalid => :replace, :replace => '')
      s.encode!('UTF-8')

      Armok::Parser::File.parse(s)
    end
  end
end
