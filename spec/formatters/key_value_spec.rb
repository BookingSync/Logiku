require "spec_helper"

module Logiku::Formatters
  RSpec.describe KeyValue do
    let(:formatter) { KeyValue.new }

    describe "#call" do
      it "returns a key value formatted string from the given hash" do
        expect(formatter.call({ string: %q{ein ' "}, symbol: :symbol }))
          .to eq %q{"string"="ein ' \\"" "symbol"=":symbol"}

        expect(formatter.call({ integer: 2, float: 3.0 }))
          .to eq %q{"integer"="2" "float"="3.0"}

        object = Object.new
        expect(formatter.call(object: object))
          .to eq %Q{"object"="#{object.inspect}"}

        expect(formatter.call(hash: { "stringkey" => 1, hash_key: "foo" }))
          .to eq %Q("hash"="{\\"stringkey\\"=>1, :hash_key=>\\"foo\\"}")

        expect(formatter.call(array: ["a", "b", "c"]))
          .to eq %Q("array"="[\\"a\\", \\"b\\", \\"c\\"]")
      end
    end
  end
end
