# frozen_string_literal: true

class Sky::Ngc::Parse
  OBJECT_TYPES = [
    STAR = "*",
    DOUBLE_STAR = "**",
    ASSOCIATION_OF_STARS = "*Ass",
    OPEN_CLUSTER = "OCl",
    GLOBULAR_CLUSTER = "GCl",
    STAR_CLUSTER_AND_NEBULA = "Cl+N",
    GALAXY = "G",
    GALAXY_PAIR = "GPair",
    GALAXY_TRIPLET = "GTrpl",
    GROUP_OF_GALAXIES = "GGroup",
    PLANETARY_NEBULA = "PN",
    HII_IONIZED_REGION = "HII",
    DARK_NEBULA = "DrkN",
    EMISSION_NEBULA = "EmN",
    NEBULA = "Neb",
    REFLECTION_NEBULA = "RfN",
    SUPERNOVA_REMNANT = "SNR",
    NOVA_STAR = "Nova",
    NONEXISTENT_OBJECT = "NonEx",
    DUPLICATED_OBJECT = "Dup",
    OTHER = "Other",
  ].freeze

  NGC_PREFIX = "NGC"
  IC_PREFIX = "IC"

  SERPENS_ABBR = "Ser"
  WRONG_SERPENS_ABBRS = %w[Se1 Se2].freeze

  def initialize(raw, constellations:)
    @raw = raw
    @constellations = constellations
  end

  def parse
    return nil if raw["Type"] == NONEXISTENT_OBJECT

    ngc_id = raw["Name"].delete(NGC_PREFIX).to_i if raw["Name"].include?(NGC_PREFIX)
    ic_id = raw["Name"].delete(IC_PREFIX).to_i if raw["Name"].include?(IC_PREFIX)

    DarkSkyObject.new(
      constellation: constellation(raw["Const"]),
      ngc_id: ngc_id,
      ic_id: ic_id,
      messier_id: raw["M"].to_i,
      category: object_type_converter(raw["Type"]),
      right_ascension: Sky::CoordinatesConverter.new(raw["RA"]).convert,
      declination: Sky::CoordinatesConverter.new(raw["Dec"]).convert,
      hubble_type: raw["Hubble"],
    )
  end

  private

  attr_reader :raw, :constellations

  def object_type_converter(object_type)
    {
      STAR => DarkSkyObject::STAR,
      DOUBLE_STAR => DarkSkyObject::DOUBLE_STAR,
      ASSOCIATION_OF_STARS => DarkSkyObject::ASSOCIATION_OF_STARS,
      OPEN_CLUSTER => DarkSkyObject::OPEN_CLUSTER,
      GLOBULAR_CLUSTER => DarkSkyObject::GLOBULAR_CLUSTER,
      STAR_CLUSTER_AND_NEBULA => DarkSkyObject::STAR_CLUSTER_AND_NEBULA,
      GALAXY => DarkSkyObject::GALAXY,
      GALAXY_PAIR => DarkSkyObject::GALAXY_PAIR,
      GALAXY_TRIPLET => DarkSkyObject::GALAXY_TRIPLET,
      GROUP_OF_GALAXIES => DarkSkyObject::GROUP_OF_GALAXIES,
      PLANETARY_NEBULA => DarkSkyObject::PLANETARY_NEBULA,
      HII_IONIZED_REGION => DarkSkyObject::HII_IONIZED_REGION,
      DARK_NEBULA => DarkSkyObject::DARK_NEBULA,
      EMISSION_NEBULA => DarkSkyObject::EMISSION_NEBULA,
      NEBULA => DarkSkyObject::NEBULA,
      REFLECTION_NEBULA => DarkSkyObject::REFLECTION_NEBULA,
      SUPERNOVA_REMNANT => DarkSkyObject::SUPERNOVA_REMNANT,
      NOVA_STAR => DarkSkyObject::NOVA_STAR,
      NONEXISTENT_OBJECT => DarkSkyObject::NONEXISTENT_OBJECT,
      DUPLICATED_OBJECT => DarkSkyObject::DUPLICATED_OBJECT,
      OTHER => DarkSkyObject::OTHER,
    }[object_type]
  end

  def constellation(abbr)
    abbr = SERPENS_ABBR if abbr.in?(WRONG_SERPENS_ABBRS)
    constellations[abbr.downcase]
  end
end
