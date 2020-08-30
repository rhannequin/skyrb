# frozen_string_literal: true

require "rails_helper"

describe Sky::CoordinatesConverter do
  subject { described_class.new(coordinates) }

  describe "#convert" do
    context "when coordinates is the smallest" do
      let(:coordinates) { "00:00:00" }

      it "returns correct value" do
        expect(subject.convert).to eq(0.0)
      end
    end

    context " when coordinates is 10:30:00" do
      let(:coordinates) { "10:30:00" }

      it "returns correct value" do
        expect(subject.convert).to eq(10.5)
      end
    end
  end
end
