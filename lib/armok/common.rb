module Armok
  # lexemes
  SPACE = '([^\[]*)'
  TAG = '([^:\]]+)'
  LB = '\['
  RB = '\]'
  COLON = ':'
  NEWLINE = "\n"
  BLANK_LINE = NEWLINE*2
  FILENAME = '([a-z_]+)'
  OBJECT = 'OBJECT:'
  TYPE = "#{SPACE}#{LB}#{OBJECT}#{TAG}#{RB}"
  ENTITIES = '(.*)'
  FILE = /^#{FILENAME}#{TYPE}#{ENTITIES}$/m
  SUBTYPE = /^#{SPACE}#{LB}#{TAG}:/m
  TOKEN = '([^\]]+)'
  TOKENS = /#{SPACE}#{LB}#{TOKEN}#{RB}#{SPACE}/m

  class Match
    attr_accessor :captures

    def initialize(s, regex)
      @captures = Array.new
      if match = s.match(regex)
        @captures = match.captures
      else
        raise(Armok::ParseError, "Could not parse: #{regex}")
      end
    end
  end

  class ParseError < StandardError
  end

end
