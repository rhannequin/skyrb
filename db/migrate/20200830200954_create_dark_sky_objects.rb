class CreateDarkSkyObjects < ActiveRecord::Migration[6.0]
  def change
    create_table :dark_sky_objects do |t|
      t.references :constellation, null: false, foreign_key: true
      t.integer :ngc_id
      t.integer :ic_id
      t.integer :messier_id
      t.integer :category
      t.decimal :right_ascension
      t.decimal :declination
      t.string :hubble_type
    end
  end
end
