# frozen_string_literal: true

FactoryBot.define do
  factory :dark_sky_object do
    constellation
    ngc_id { 6853 }
    ic_id { nil }
    messier_id { 27 }
    category { 0 }
    right_ascension { 19.993439 }
    declination { 22.721028 }
    hubble_type { nil }
  end
end
