# frozen_string_literal: true

require "csv"

class Sky::Constellations
  FILE_PATH = Rails.root.join("vendor/constellations/names.csv")

  def load
    records = constellations.map do |constellation|
      ::Constellation.new(
        abbreviation: constellation["abbr"],
        name: constellation["latin_name"],
      )
    end

    ::Constellation.import!(records)
  end

  private

  def constellations
    CSV.read(FILE_PATH, headers: true)
  end
end
