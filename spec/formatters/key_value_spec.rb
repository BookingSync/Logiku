require "spec_helper"

module Logiku::Formatters
  RSpec.describe KeyValue do
    let(:formatter) { KeyValue.new }

    describe "#call" do
      it "returns a key value formatted string from the given hash" do
        expect(formatter.call({ string: %Q{ein ' "\nstring}, symbol: :symbol }))
          .to eq %Q{"string"="ein ' \\" string" "symbol"=":symbol"\n}

        expect(formatter.call({ integer: 2, float: 3.0 }))
          .to eq %Q{"integer"="2" "float"="3.0"\n}

        object = Object.new
        expect(formatter.call(object: object))
          .to eq %Q{"object"="#{object.inspect}"\n}

        expect(formatter.call(hash: { "stringkey" => 1, hash_key: "foo\nbar" }))
          .to eq %Q("hash"="{\\"stringkey\\"=>1, :hash_key=>\\"foo\\nbar\\"}"\n)

        expect(formatter.call(array: ["a", "b", "c"]))
          .to eq %Q("array"="[\\"a\\", \\"b\\", \\"c\\"]"\n)

        time = Time.now
        expect(formatter.call(time: time))
          .to eq %Q("time"="#{time.utc.iso8601(6)}"\n)
      end

      context "when initialized with a filter" do
        class DummyFilter
          def call(message)
            message.gsub("secret", "FILTERED")
          end
        end

        let(:formatter) { KeyValue.new(DummyFilter.new) }

        it "applies it after formatting" do
          expect(formatter.call({ user: "joe", password: "secret" }))
            .to eq %Q("user"="joe" "password"="FILTERED"\n)
        end
      end
    end
  end
end
