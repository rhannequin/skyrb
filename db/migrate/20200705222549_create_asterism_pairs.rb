# frozen_string_literal: true

class CreateAsterismPairs < ActiveRecord::Migration[6.0]
  def change
    create_table :asterism_pairs do |t|
      t.references :constellation, null: false
      t.integer :star1_id, null: false
      t.integer :star2_id, null: false

      t.timestamps
    end
  end
end
