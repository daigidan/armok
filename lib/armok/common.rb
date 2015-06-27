#  A small Ruby library for working with the raw files of Dwarf Fortress.
module Armok
  VERSION = '0.1.0'

  # lexemes
  SPACE = '([^\[]*)'
  TAG = '([^:\]]+)'
  LB = '\['
  RB = '\]'
  COLON = ':'
  FILENAME = '([a-zA-Z0-9_]+)'
  OBJECT = 'OBJECT:'
  TYPE = "#{SPACE}#{LB}#{OBJECT}#{TAG}#{RB}"
  OBJECTS = '(.*)'
  TOKEN = '([^\]]+)'

  # regexps
  FILE = /^#{FILENAME}#{TYPE}#{OBJECTS}$/m
  SUBTYPE = /^#{SPACE}#{LB}#{TAG}#{COLON}/m
  TOKENS = /#{SPACE}#{LB}#{TOKEN}#{RB}#{SPACE}/m

  # Utility for capturing values using regexps.
  class Match
    def self.capture(s, regex)
      if (match = s.match(regex))
        match.captures.length > 1 ? match.captures : match.captures[0]
      else
        fail(Armok::ParseError, "Could not parse: #{regex}")
      end
    end
  end

  class ParseError < StandardError
  end
end
