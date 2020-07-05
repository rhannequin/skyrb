# frozen_string_literal: true

class Constellation < ApplicationRecord
  has_many :stars, dependent: :destroy
end
