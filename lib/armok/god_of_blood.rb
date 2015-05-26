module Armok
  class GodOfBlood

    def initialize(raws_dir)
      @raws_dir = raws_dir
      @parser = Armok::Parser.new
      @token_data = {}
      Dir.glob("#{raws_dir}/*.txt").each {|filename|
        puts filename
        begin
          file = @parser.parse(File.read(filename))
        rescue Citrus::ParseError => e
          puts e.message
        end
      }
    end

  end
end
