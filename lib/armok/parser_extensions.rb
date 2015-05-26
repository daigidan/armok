module Extensions
  # below are modules which are used to extend the parser grammar
  # see dfraw.citrus for details on where they plug in

  module File
    def to_s
      s = "#{name}\n\n[OBJECT:#{type}]\n"
      tokens.map {|t| s += "\n[#{t.to_s}]" }
      return s
    end

    def defs
      Hash[captures(:definition).map {|d| [d.id, d.tokens]}]
    end

    def name
      capture(:name).value
    end

    def type
      capture(:declaration).capture(:value).value
    end
  end

  module Definition
    def type
      capture(:key).value
    end

    def id
      capture(:value).value
    end

    def tokens
      Hash[captures(:token).map {|t| [t.key, t.to_s => t.values]}]
    end
  end

  module Token
    def to_s
      "#{key}#{values.map {|v| ':'+v }.join}"
    end

    def key
      capture(:key).value
    end

    def values
      captures(:value).map {|v| v.value }
    end
  end

end
