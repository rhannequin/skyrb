# frozen_string_literal: true

require "csv"

class Sky::Constellations
  FILE_PATH = Rails.root.join("vendor/constellations/names.csv")

  def load
    records = constellations.map do |constellation|
      {
        abbreviation: constellation["abbr"],
        name: constellation["latin_name"],
      }
    end

    ::Constellation.create(records)
  end

  private

  def constellations
    CSV.read(FILE_PATH, headers: true)
  end
end
