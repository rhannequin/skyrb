# frozen_string_literal: true

FactoryBot.define do
  factory :star do
    constellation
    hip_id { 32_349 }
    hd_id { 48_915 }
    hr_id { 2491 }
    gl_id { 0 }
    name { "Sirius" }
    right_ascension { 6.752481 }
    declination { -16.716116 }
    apparent_magnitude { 1.44 }
    asbolute_magnitude { 1.454 }
    luminosity { 22.824433121735 }
    distance { 81_372_403_501_508_800.0 }
  end
end
