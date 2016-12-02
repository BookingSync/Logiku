require "spec_helper"

module Logiku::Normalizers
  class DummyFormatter
    def call(data)
      data
    end
  end

  RSpec.describe ActiveSupport do
    describe "#call" do
      let(:normalizer) { ActiveSupport.new(DummyFormatter.new) }
      let(:severity) { "INFO" }
      let(:timestamp) { Time.now }
      let(:progname) { "foo" }
      let(:message) { { object_id: "123" } }
      let(:data) { normalizer.call severity, timestamp, progname, message }

      context "when message is a hash" do
        it "creates one hash from arguments, merging message hash into it" do
          expect(data).to eq({
            severity: severity,
            time: timestamp,
            progname: progname,
            object_id: "123"
          })
        end
      end

      context "when message is nil" do
        let(:message) { nil }

        it "does not add the message key" do
          expect(data).to eq({
            severity: severity,
            time: timestamp,
            progname: progname
          })
        end
      end

      context "when message is a String" do
        let(:message) { "some string" }

        it "considers it already formatted and returns it as is" do
          expect(data).to eq message
        end
      end
    end
  end
end
