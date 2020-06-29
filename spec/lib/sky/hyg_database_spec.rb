# frozen_string_literal: true

require "rails_helper"
require "csv"

describe Sky::HygDatabase do
  subject { described_class.new }

  describe "#parse" do
    let(:name) { "Sirius" }
    let(:const) { "CMa" }
    let(:ra) { 6.752481 }
    let(:dec) { -16.716116 }
    let(:mag) { -1.440 }

    let(:headers) do
      %w[
        id hip hd hr gl bf proper ra dec dist pmra pmdec rv mag absmag spect ci
        x y z vx vy vz rarad decrad pmrarad pmdecrad bayer flam con comp
        comp_primary base lum var var_min var_max
      ]
    end

    let(:entry) do
      [
        32_263, 32_349, 48_915, 2491, "Gl 244A", "9Alp CMa", name, ra, dec,
        2.6371, -546.01, -1223.08, -9.4, mag, 1.454, "A0m...", 0.009, -0.494323,
        2.476731, -0.758485, 0.00000953, -0.00001207, -0.00001221,
        1.7677953696021995, -0.291751258517685, -0.000002647131177201389,
        -0.000005929659164, "Alp", 9, const, "1,32263", "Gl 244",
        22.824433121735034, "", -1.333, -1.523,
      ]
    end

    let(:mocked_csv) do
      CSV.generate do |csv|
        csv << headers
        csv << entry
      end
    end

    before do
      csv = CSV.new(mocked_csv, headers: true, converters: %i[numeric])

      allow(CSV).to(
        receive(:read)
          .and_return(csv)
      )
    end

    it "parses values correctly" do
      star = subject.parse.last
      expect(star.proper).to eq(name)
      expect(star.con).to eq(const)
      expect(star.ra).to eq(ra)
      expect(star.dec).to eq(dec)
    end

    context "when magnitude is too high" do
      let(:mag) { described_class::MAX_MAGNITUDE + 1 }

      it "ignore the star" do
        expect(subject.parse).to be_empty
      end
    end
  end
end
