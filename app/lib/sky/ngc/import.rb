# frozen_string_literal: true

require "csv"

class Sky::Ngc::Import
  FILE_PATH = Rails.root.join("vendor/ngc_processed.csv")
  SEPARATOR = ";"

  def load!
    dark_sky_objects = []

    ngc_objects.each do |ngc_object|
      dark_sky_objects << Sky::Ngc::Parse.new(
        ngc_object,
        constellations: constellations,
      ).parse
    end

    DarkSkyObject.import(dark_sky_objects.compact)
  end

  private

  def ngc_objects
    CSV.read(FILE_PATH, **options)
  end

  def options
    {
      headers: true,
      col_sep: SEPARATOR,
    }
  end

  def converters
    {
      converters: %i[numeric],
    }
  end

  def constellations
    @constellations ||= begin
      consts = {}
      Constellation.find_each do |constellation|
        consts[constellation.abbreviation.downcase] = constellation
      end
      consts
    end
  end
end
