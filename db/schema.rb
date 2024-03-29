# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_30_200954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asterism_pairs", force: :cascade do |t|
    t.bigint "constellation_id", null: false
    t.integer "star1_id", null: false
    t.integer "star2_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["constellation_id"], name: "index_asterism_pairs_on_constellation_id"
  end

  create_table "constellations", force: :cascade do |t|
    t.string "abbreviation"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["abbreviation"], name: "index_constellations_on_abbreviation"
  end

  create_table "dark_sky_objects", force: :cascade do |t|
    t.bigint "constellation_id", null: false
    t.integer "ngc_id"
    t.integer "ic_id"
    t.integer "messier_id"
    t.integer "category"
    t.decimal "right_ascension"
    t.decimal "declination"
    t.string "hubble_type"
    t.index ["constellation_id"], name: "index_dark_sky_objects_on_constellation_id"
  end

  create_table "stars", force: :cascade do |t|
    t.bigint "constellation_id", null: false
    t.integer "hip_id"
    t.integer "hd_id"
    t.integer "hr_id"
    t.integer "gl_id"
    t.string "name"
    t.decimal "right_ascension"
    t.decimal "declination"
    t.decimal "apparent_magnitude"
    t.decimal "asbolute_magnitude"
    t.decimal "luminosity"
    t.decimal "distance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["constellation_id"], name: "index_stars_on_constellation_id"
  end

  add_foreign_key "dark_sky_objects", "constellations"
end
