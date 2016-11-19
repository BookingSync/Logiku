require "spec_helper"

module Logiku::Normalizers
  RSpec.describe ActiveSupport do
    describe "#call" do
      let(:normalizer) { ActiveSupport.new }
      let(:severity) { "INFO" }
      let(:timestamp) { Time.now.utc }
      let(:progname) { "foo" }
      let(:message) { { object_id: "123" } }
      let(:data) { normalizer.call severity, timestamp, progname, message }

      it "creates one hash from arguments" do
        expect(data).to eq({
          severity: severity,
          timestamp: timestamp,
          progname: progname,
          object_id: "123"
        })
      end

      context "when message is nil" do
        let(:message) { nil }

        it "still works" do
          expect(data).to eq({
            severity: severity,
            timestamp: timestamp,
            progname: progname
          })
        end
      end
    end
  end
end
