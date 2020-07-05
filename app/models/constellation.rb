# frozen_string_literal: true

class Constellation < ApplicationRecord
  has_many :stars, dependent: :destroy

  def self.abbr(abridged_name)
    find_by!(abbreviation: abridged_name)
  end
end
