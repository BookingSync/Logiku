module Logiku::Normalizers
  class ActiveSupport
    def initialize(formatter)
      @formatter = formatter
    end

    def call(severity, timestamp, progname, message)
      if message.kind_of? String
        message
      else
        data = {
          severity: severity,
          time: timestamp,
          progname: progname
        }

        data.merge! message if message.kind_of? Hash

        formatter.call(data.reject { |_, value| value.nil? })
      end
    end

    private

    attr_reader :formatter
  end
end
