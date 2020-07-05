# frozen_string_literal: true

class AsterismPair < ApplicationRecord
  belongs_to :constellation
  belongs_to :star1, class_name: "Star"
  belongs_to :star2, class_name: "Star"
end
