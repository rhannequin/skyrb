# frozen_string_literal: true

require "csv"

class Sky::HygDatabase
  FILE_PATH = Rails.root.join("vendor/hyg/hygdata_v3.csv")
  AVOIDED_STAR_NAMES = %w[Sol].freeze
  MAX_MAGNITUDE = 6.5

  def parse
    stars.filter_map do |star|
      next if star["mag"] > MAX_MAGNITUDE
      next if star["proper"].in?(AVOIDED_STAR_NAMES)

      OpenStruct.new(star)
    end
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
end
