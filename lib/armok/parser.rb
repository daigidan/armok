require 'citrus'

module Armok
  class Parser
    attr_reader :match, :input, :name, :type, :definitions

    def initialize(s)
      Citrus.load('dfraw') # load grammar and its namespace
      @match = DFRaw.parse(s)
      @input = s
      @name = @match.name
      @type = @match.type
      @definitions = @match.definitions
    end

    def inspect
      @match
    end

    # below are modules which are used to extend the grammar
    # see dfraw.citrus for details on where they plug in

    module File
      def to_s
        s = "#{name}\n\n[OBJECT:#{type}]\n"
        definitions.each {|d|
          s << "\n[#{d.subtype}:#{d.id}]\n"
          d.attributes.each {|a|
            s << "[#{a.to_s}]\n"
          }
        }
        return s
      end

      def definitions
        captures(:definition)
      end

      def name
        capture(:file_name_line).capture(:name)
      end

      def type
        capture(:declaration).capture(:type)
      end
    end

    module Attribute
      def to_s
        "#{key}#{values_to_s}"
      end

      def key
        capture(:name).value
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

    module Object
      def attributes
        capture(:attributes).captures(:attribute_line).map {|a|
          a.capture(:attribute)
        }
      end

      def subtype
        capture(:type)
      end

      def id
        capture(:id)
      end
    end
    
  end
end
