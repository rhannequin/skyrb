# frozen_string_literal: true

require "rails_helper"

describe Sky::Ngc::Parse do
  subject { described_class.new(raw, constellations: constellations) }

  let(:raw) do
    {
      "Name" => name,
      "Type" => "PN",
      "RA" => "19:59:36.38",
      "Dec" => "+22:43:15.7",
      "Const" => constellation_abbreviation,
      "MajAx" => "6.70",
      "MinAx" => "",
      "PosAng" => "",
      "B-Mag" => "7.60",
      "V-Mag" => "7.40",
      "J-Mag" => "11.79",
      "H-Mag" => "10.61",
      "K-Mag" => "",
      "SurfBr" => "",
      "Hubble" => "",
      "Cstar U-Mag" => "12.43",
      "Cstar B-Mag" => "13.66",
      "Cstar V-Mag" => "13.94",
      "M" => messier,
      "NGC" => "",
      "IC" => "",
      "Cstar Names" => "BD+22 3878",
      "Identifiers" => "2MASX J19593637+2243157,PN G060.8-03.6",
      "Common names" => "Dumbbell Nebula",
    }
  end

  let(:constellations) do
    {
      constellation_abbreviation_down => FactoryBot.create(
        :constellation,
        abbreviation: constellation_abbreviation,
      ),
    }
  end

  let(:ngc_id) { 6853 }
  let(:name) { "NGC#{ngc_id}" }
  let(:constellation_abbreviation) { "Vul" }
  let(:constellation_abbreviation_down) { constellation_abbreviation.downcase }
  let(:messier) { "" }
  let(:ic_id) { "" }

  describe "#parse" do
    let(:dso) { subject.parse }

    it "returns a new DarkSkyObject instance" do
      expect(dso).to be_a(DarkSkyObject)
    end

    it "converts right ascension into a BigDecimal" do
      expect(dso.right_ascension).to be_a(BigDecimal)
    end

    it "converts declination into a BigDecimal" do
      expect(dso.declination).to be_a(BigDecimal)
    end

    it "gets the right constellation" do
      expect(dso.constellation).to(
        eq(constellations[constellation_abbreviation_down])
      )
    end

    it "converts the object's category" do
      expect(DarkSkyObject::CATEGORIES).to include(dso.category.to_sym)
    end

    it "sets NGC ID" do
      expect(dso.ngc_id).to eq(ngc_id)
    end

    context "when it is part of the Messier catalog" do
      let(:messier) { "027" }

      it "sets it" do
        expect(dso.messier_id).to eq(messier.to_i)
      end
    end

    context "when it is a IC object" do
      let(:ic_id) { 1234 }
      let(:name) { "IC#{ic_id}" }

      it "sets it" do
        expect(dso.ic_id).to eq(ic_id)
      end

      it "doesn't set ngc_id" do
        expect(dso.ngc_id).to be_nil
      end
    end
  end
end
