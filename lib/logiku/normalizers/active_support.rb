module Logiku::Normalizers
  class ActiveSupport
    def call(severity, timestamp, progname, message)
      data = {
        severity: severity,
        timestamp: timestamp,
        progname: progname
      }
      data.merge! message unless message.nil?
      data
    end
  end
end
