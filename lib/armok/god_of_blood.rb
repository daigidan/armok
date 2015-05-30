module Armok
  class GodOfBlood
    attr_reader :d, :errors

    def initialize(raws_dir=nil)
      @raws_dir = raws_dir
      @file = Armok::File.new
      @d = {}
      @errors = []
      shape(raws_dir) if raws_dir
    end

    def shape(raws_dir)
      @raws_dir = raws_dir
      Dir.glob("#{raws_dir}/*.txt").each {|f|
        begin
          f = @file.parse(f)
        rescue Armok::Error => e
          @errors << "##{f}: #{e.message}"
          next
        end

        if @d.has_key?(f.type)
          @d[f.type].merge!(f.defs)
        else
          @d[f.type] = f.defs
        end
      }
    end

    def parse(filename)
      @file.read(Kernel::File.read(filename))
    end

  end
end
