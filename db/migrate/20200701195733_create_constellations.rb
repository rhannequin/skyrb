# frozen_string_literal: true

class CreateConstellations < ActiveRecord::Migration[6.0]
  def change
    create_table :constellations do |t|
      t.string :abbreviation
      t.string :name, null: false

      t.timestamps

      t.index :abbreviation
    end
  end
end
