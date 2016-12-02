module Logiku::Normalizers
  class ActiveSupport
    def initialize(formatter)
      @formatter = formatter
    end

    def call(severity, timestamp, progname, message)
      data = {
        severity: severity,
        timestamp: timestamp,
        progname: progname
      }

      data.merge! message if message.kind_of? Hash
      data[:message] = message if message.kind_of? String

      formatter.call(data.reject { |_, value| value.nil? })
    end

    private

    attr_reader :formatter
  end
end
