# frozen_string_literal: true

require "rails_helper"

describe Sky::Ngc::Import do
  subject { described_class.new }

  describe "#load!" do
    let(:headers) do
      %w[
        Name Type RA Dec Const MajAx MinAx PosAng B-Mag V-Mag J-Mag H-Mag K-Mag
        SurfBr Hubble Cstar\ U-Mag Cstar\ B-Mag Cstar\ V-Mag M NGC IC
        Cstar\ Names Identifiers Common\ names
      ]
    end

    let(:entries) do
      [
        "NGC6853", "PN", "19:59:36.38", "+22:43:15.7", "Vul", "6.70", "", "",
        "7.60", "7.40", "11.79", "10.61", "", "", "", "12.43", "13.66", "13.94",
        "027", "", "", "BD+22 3878", "2MASX J19593637+2243157,PN G060.8-03.6",
        "Dumbbell Nebula",
      ]
    end

    let(:mocked_csv) do
      CSV.generate do |csv|
        csv << headers
        csv << entries
      end
    end

    before do
      csv = CSV.new(mocked_csv, headers: true)
      allow(CSV).to(receive(:read).and_return(csv))
    end

    context "when it is properly parsed" do
      let(:new_dark_sky_object) do
        FactoryBot.build(:dark_sky_object, constellation: constellation)
      end

      let(:constellation) { FactoryBot.create(:constellation) }
      let(:parse_service) { double(Sky::Ngc::Parse) }

      before do
        allow(Sky::Ngc::Parse).to receive(:new).and_return(parse_service)
        allow(parse_service).to(
          receive(:parse).and_return(new_dark_sky_object)
        )
      end

      it "creates a new DarkSkyObject record" do
        expect { subject.load! }.to change { DarkSkyObject.count }.by(1)
      end
    end

    context "when it is not properly parsed" do
      let(:parse_service) { double(Sky::Ngc::Parse) }

      before do
        allow(Sky::Ngc::Parse).to receive(:new).and_return(parse_service)
        allow(parse_service).to(
          receive(:parse).and_return(nil)
        )
      end

      it "doesn't create a new DarkSkyObject record" do
        expect { subject.load! }.not_to(change { DarkSkyObject.count })
      end
    end
  end
end
