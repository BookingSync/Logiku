module Logiku::Formatters
  class KeyValue
    attr_reader :filter

    def initialize(filter = nil)
      @filter = filter
    end

    def call(data)
      message = "#{data.map { |k, v| format k, v }.join(" ")}\n"
      message = filter.call(message) unless filter.nil?
      message
    end

    private

    def format(k, v)
      %Q{"#{k}"="#{format_value v}"}
    end

    def format_value(v)
      case v
      when String
        v.gsub(/["\n]/, { '"' => '\"', "\n" => " " })
      when Hash, Array
        v.inspect.gsub('"') { %q|\"| }
      when Time
        v.utc.iso8601(6)
      else
        v.inspect
      end
    end
  end
end
