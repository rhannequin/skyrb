# frozen_string_literal: true

class CreateStars < ActiveRecord::Migration[6.0]
  def change
    create_table :stars do |t|
      t.references :constellation, null: false
      t.integer :hip_id
      t.integer :hd_id
      t.integer :hr_id
      t.integer :gl_id
      t.string :name
      t.decimal :right_ascension
      t.decimal :declination
      t.decimal :apparent_magnitude
      t.decimal :asbolute_magnitude
      t.decimal :luminosity
      t.decimal :distance # in m

      t.timestamps
    end
  end
end
