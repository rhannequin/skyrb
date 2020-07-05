# frozen_string_literal: true

require "csv"

class Sky::HygDatabase
  FILE_PATH = Rails.root.join("vendor/hyg/hygdata_v3.csv")
  AVOIDED_STAR_NAMES = %w[Sol].freeze
  MAX_MAGNITUDE = 6.5
  PARSEC_IN_METERS = 30_856_775_814_913_673

  def load!
    records = stars.filter_map do |star|
      next if star["mag"] > MAX_MAGNITUDE
      next if star["proper"].in?(AVOIDED_STAR_NAMES)

      constellation = constellations.find do |const|
        const.abbreviation.casecmp(star["con"]).zero?
      end

      ::Star.new(
        constellation_id: constellation.id,
        hip_id: star["hyp"],
        hd_id: star["hd"],
        hr_id: star["hr"],
        gl_id: star["gl"],
        name: star["proper"],
        right_ascension: star["ra"],
        declination: star["dec"],
        distance: star["dist"] * PARSEC_IN_METERS,
        apparent_magnitude: star["mag"],
        asbolute_magnitude: star["absmag"],
        luminosity: star["lum"],
      )
    end

    ::Star.import!(records)
  end

  private

  def stars
    CSV.read(FILE_PATH, **options)
  end

  def options
    {
      headers: true,
    }.merge(converters)
  end

  def converters
    {
      converters: %i[numeric],
    }
  end

  def constellations
    @constellations ||= ::Constellation.all
  end
end
