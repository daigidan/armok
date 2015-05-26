module Extensions
  # below are modules which are used to extend the parser grammar
  # see dfraw.citrus for details on where they plug in

  module File
    def to_s
      s = "#{name}\n\n[OBJECT:#{type}]\n"
      tokens.map {|t| s += "\n[#{t.to_s}]" }
      return s
    end

    def definitions
      captures(:definition)
    end

    def name
      capture(:name)
    end

    def type
      capture(:declaration).capture(:value)
    end
  end

  module Definition
    def type
      capture(:key)
    end

    def id
      capture(:value)
    end

    def tokens
      captures(:token)
    end
  end

  module Token
    def to_s
      "#{key}#{values_to_s}"
    end

    def key
      capture(:key)
    end

    def values
      captures(:value)
    end

    def values_to_s
      values.map { |v| ':' + v }.join
    end

    def value
      captures(:value)[0]
    end
  end

end
