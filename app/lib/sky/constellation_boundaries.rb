# frozen_string_literal: true

class Sky::ConstellationBoundaries
  attr_reader :boundaries

  FILE_PATH = Rails.root.join("vendor/constellations/boundaries.dat")
  LOWER_RA_RANGE = (0..7).freeze
  UPPER_RA_RANGE = (9..15).freeze
  DEC_RANGE = (17..24).freeze
  ABBREVIATION_RANGE = (26..28).freeze

  def initialize
    @boundaries = []
  end

  def parse
    content.each_line do |boundary|
      @boundaries << OpenStruct.new(
        lower_ra: boundary[LOWER_RA_RANGE].to_f,
        upper_ra: boundary[UPPER_RA_RANGE].to_f,
        dec: boundary[DEC_RANGE].to_f,
        abbr: boundary[ABBREVIATION_RANGE],
      )
    end
  end

  private

  def content
    File.read(FILE_PATH)
  end
end
