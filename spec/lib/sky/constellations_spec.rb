# frozen_string_literal: true

require "rails_helper"
require "csv"

describe Sky::Constellations do
  subject { described_class.new }

  describe "#load!" do
    let(:headers) { %w[abbr latin_name] }
    let(:entries) do
      [
        %w[Mct Myconstellation],
      ]
    end

    let(:mocked_csv) do
      CSV.generate do |csv|
        csv << headers
        entries.each { |entry| csv << entry }
      end
    end

    before do
      csv = CSV.new(mocked_csv, headers: true)

      allow(CSV).to(
        receive(:read)
          .and_return(csv)
      )
    end

    it "creates new constellations" do
      expect { subject.load! }.to(
        change { ::Constellation.count }.by(entries.size)
      )
    end

    it "inserts the correct values" do
      subject.load!
      first_line = entries.first
      constellation = ::Constellation.last
      expect(constellation.abbreviation).to eq(first_line.first)
      expect(constellation.name).to eq(first_line.second)
    end
  end
end
