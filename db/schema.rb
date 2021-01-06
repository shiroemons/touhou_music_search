# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_06_110118) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "discographies", force: :cascade do |t|
    t.string "wrapper_type", null: false
    t.string "collection_type", null: false
    t.bigint "apple_artist_id", null: false
    t.bigint "apple_collection_id", null: false
    t.string "artist_name", null: false
    t.string "collection_name", null: false
    t.string "collection_censored_name", null: false
    t.string "artist_view_url", null: false
    t.text "collection_view_url", null: false
    t.string "artwork_url60", null: false
    t.string "artwork_url100", null: false
    t.integer "collection_price"
    t.string "collection_explicitness", null: false
    t.integer "track_count", null: false
    t.string "copyright", null: false
    t.string "country", null: false
    t.string "currency", null: false
    t.datetime "release_date", null: false
    t.string "primary_genre_name", null: false
    t.boolean "is_touhou", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["apple_artist_id"], name: "index_discographies_on_apple_artist_id"
    t.index ["apple_collection_id"], name: "index_discographies_on_apple_collection_id", unique: true
  end

  create_table "master_artists", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "apple_artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "original_songs", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "original_code", null: false
    t.string "title", null: false
    t.string "composer", default: "", null: false
    t.integer "track_number", null: false
    t.boolean "is_duplicate", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_original_songs_on_code", unique: true
    t.index ["original_code"], name: "index_original_songs_on_original_code"
  end

  create_table "originals", primary_key: "code", id: :string, force: :cascade do |t|
    t.string "title", null: false
    t.string "short_title", null: false
    t.string "original_type", null: false
    t.float "series_order", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
