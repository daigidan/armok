module Armok
  # lexemes
  SPACE = '[^\[]*'
  TAG = '([^:\]]+)'
  LB = '\['
  RB = '\]'
  COLON = ':'
  NEWLINE = "\n"
  BLANK_LINE = NEWLINE*2
  FILENAME = '([a-z_]+)'
  TYPE = "#{SPACE}#{LB}OBJECT:#{TAG}#{RB}"
  ENTITIES = '(.*)'
  TOKEN = '([^\]]+)'

  class Match
    attr_accessor :captures

    def initialize(s, regex)
      @captures = Array.new
      if match = s.match(regex)
        @captures = match.captures
      else
        raise(Armok::Error, "Could not parse: #{regex}")
      end
    end
  end

  class Error < StandardError
  end

end
