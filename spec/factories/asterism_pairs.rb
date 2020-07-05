# frozen_string_literal: true

FactoryBot.define do
  factory :asterism_pair do
    constellation
    star1 { association :star }
    star2 { association :star }
  end
end
