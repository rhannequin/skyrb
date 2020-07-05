# frozen_string_literal: true

class Sky::Asterisms
  FILE_PATH = Rails.root.join("vendor/constellations/constellationships.fab")
  ABBR_RANGE = (0..2).freeze
  PAIRS_COUNT_RANGE = (4..5).freeze
  PAIRS_RANGE = (7..).freeze

  def load!
    records = []

    constellationships.each_line do |constellationship|
      constellation = find_constellation(constellationship[ABBR_RANGE])

      pairs_count = constellationship[PAIRS_COUNT_RANGE].to_i
      pairs = constellationship[PAIRS_RANGE].strip.split(/\s/)

      asterism_pairs = (0...pairs_count).to_a.each_with_index.map do |_, i|
        star1 = ::Star.find_by!(hip_id: pairs[i * 2].to_i)
        star2 = ::Star.find_by!(hip_id: pairs[i * 2 + 1].to_i)

        ::AsterismPair.new(
          constellation: constellation,
          star1: star1,
          star2: star2,
        )
      end

      records.concat(asterism_pairs)
    end

    ::AsterismPair.import!(records)
  end

  private

  def constellationships
    File.read(FILE_PATH)
  end

  def constellations
    @constellations ||= ::Constellation.all
  end

  def find_constellation(abbreviation)
    constellations.find do |const|
      const.abbreviation.casecmp(abbreviation).zero?
    end
  end
end
