# frozen_string_literal: true

require "rails_helper"

describe Sky::ConstellationFromRadec do
  subject { described_class.new(right_ascension, declination) }

  brightest_stars = [
    { ra: 6.752481, dec: -16.716116, const: "CMa" },
    { ra: 6.399195, dec: -52.695660, const: "Car" },
    { ra: 14.495985, dec: -62.679485, const: "Cen" },
    { ra: 14.261030, dec: 19.182410, const: "Boo" },
    { ra: 18.615640, dec: 38.783692, const: "Lyr" },
    { ra: 5.278150, dec: 45.997991, const: "Aur" },
    { ra: 5.242298, dec: -8.201640, const: "Ori" },
    { ra: 7.655033, dec: 5.224993, const: "CMi" },
    { ra: 1.628556, dec: -57.236757, const: "Eri" },
    { ra: 5.919529, dec: 7.407063, const: "Ori" },
  ].freeze

  describe "#constellation" do
    brightest_stars.map do |coord|
      context "for right_ascension(#{coord[:ra]}) and declination ((#{coord[:dec]}))" do
        let(:right_ascension) { coord[:ra] }
        let(:declination) { coord[:dec] }

        it "returns the correct constellation" do
          expect(subject.constellation).to eq(coord[:const])
        end
      end
    end
  end
end
