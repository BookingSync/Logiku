module Logiku::Formatters
  class KeyValue
    def call(data)
      data.map { |k, v| format k, v }.join " "
    end

    private

    def format(k, v)
      %Q{"#{k}"="#{format_value v}"}
    end

    def format_value(v)
      case v
      when String
        v.gsub('"') { %q|\"| }
      when Hash, Array
        v.inspect.gsub('"') { %q|\"| }
      else
        v.inspect
      end
    end
  end
end
