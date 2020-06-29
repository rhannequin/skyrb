# frozen_string_literal: true

require "rails_helper"

describe Sky::ConstellationBoundaries do
  subject { described_class.new }

  describe "#parse" do
    let(:mocked_content) do
      [
        " 12.3456 78.9100  12.3456 Cst",
        "  1.2345 67.8910  12.3456 Cst",
        " 12.3456 78.9100 -12.3456 Cst",
      ].join("\n")
    end

    before do
      allow(File).to(
        receive(:read)
          .and_return(StringIO.new(mocked_content.to_s))
      )
    end

    it "parses values correctly" do
      subject.parse
      expect(subject.boundaries[0].lower_ra).to eq(12.3456)
      expect(subject.boundaries[1].upper_ra).to eq(67.8910)
      expect(subject.boundaries[2].dec).to eq(-12.3456)
      expect(subject.boundaries[2].abbr).to eq("Cst")
    end
  end
end
