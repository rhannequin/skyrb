# frozen_string_literal: true

require "rails_helper"
require "csv"

describe Constellation, type: :model do
  describe "::abbr" do
    let(:constellation) { FactoryBot.create(:constellation) }

    it "returns a constellation based on its abbreviation" do
      expect(described_class.abbr(constellation.abbreviation)).to(
        eq(constellation)
      )
    end

    context "when the constellation does not exist" do
      it "raises" do
        expect { described_class.abbr("WRONG") }.to(
          raise_error(ActiveRecord::RecordNotFound)
        )
      end
    end
  end

  describe "#asterism" do
    let(:constellation) { FactoryBot.create(:constellation) }

    let!(:asterism_pair) do
      FactoryBot.create(:asterism_pair, constellation: constellation)
    end

    it "returns a list of AsterismPairs" do
      expect(constellation.asterism).to eq([asterism_pair])
    end
  end
end
