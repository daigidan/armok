#  A small Ruby library for working with the raw files of Dwarf Fortress.
module Armok
  VERSION = '0.1.0'

  # lexemes
  SPACE = '([^\[]*)'
  TAG = '([^:\]]+)'
  LB = '\['
  RB = '\]'
  COLON = ':'
  NEWLINE = "\n"
  BLANK_LINE = NEWLINE * 2
  FILENAME = '([a-zA-Z0-9_]+)'
  OBJECT = 'OBJECT:'
  TYPE = "#{SPACE}#{LB}#{OBJECT}#{TAG}#{RB}"
  ENTITIES = '(.*)'
  FILE = /^#{FILENAME}#{TYPE}#{ENTITIES}$/m
  SUBTYPE = /^#{SPACE}#{LB}#{TAG}:/m
  TOKEN = '([^\]]+)'
  TOKENS = /#{SPACE}#{LB}#{TOKEN}#{RB}#{SPACE}/m

  # A utility for capturing values using regexps.
  class Match
    attr_accessor :captures

    def initialize(s, regex)
      @captures = []
      if (match = s.match(regex))
        @captures = match.captures
      else
        fail(Armok::ParseError, "Could not parse: #{regex}")
      end
    end
  end

  class ParseError < StandardError
  end
end
