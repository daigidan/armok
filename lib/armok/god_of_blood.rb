module Armok
  class GodOfBlood
    attr_reader :d

    def initialize(raws_dir=nil)
      @raws_dir = raws_dir
      @parser = Armok::Parser.new
      @d = {}
      control(raws_dir) if raws_dir
    end

    def control(raws_dir)
      @raws_dir = raws_dir
      Dir.glob("#{raws_dir}/*.txt").each {|f|
        begin
          f = parse_file(f)
        rescue Citrus::ParseError => e
          puts e.message
          next
        end

        if @d.has_key?(f.type)
          @d[f.type].merge!(f.defs)
        else
          @d[f.type] = f.defs
        end
      }
    end

    def parse(s)
      @parser.parse(s)
    end

    def parse_file(f)
      parse(File.read(f))
    end
  end
end
