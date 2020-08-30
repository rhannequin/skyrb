# frozen_string_literal: true

class DarkSkyObject < ApplicationRecord
  CATEGORIES = [
    STAR = :star,
    DOUBLE_STAR = :double_star,
    ASSOCIATION_OF_STARS = :association_of_stars,
    OPEN_CLUSTER = :open_cluster,
    GLOBULAR_CLUSTER = :globular_cluster,
    STAR_CLUSTER_AND_NEBULA = :star_cluster_and_nebula,
    GALAXY = :galaxy,
    GALAXY_PAIR = :galaxy_pair,
    GALAXY_TRIPLET = :galaxy_triplet,
    GROUP_OF_GALAXIES = :group_of_galaxies,
    PLANETARY_NEBULA = :platenary_nebula,
    HII_IONIZED_REGION = :hii_ionized_region,
    DARK_NEBULA = :dark_nebula,
    EMISSION_NEBULA = :emission_nebula,
    NEBULA = :nebula,
    REFLECTION_NEBULA = :reflection_nebula,
    SUPERNOVA_REMNANT = :supernova_remnant,
    NOVA_STAR = :nova_star,
    NONEXISTENT_OBJECT = :nonexistent_object,
    DUPLICATED_OBJECT = :duplicated_object,
    OTHER = :other,
  ].freeze

  belongs_to :constellation

  enum category: CATEGORIES
end
