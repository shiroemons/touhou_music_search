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

ActiveRecord::Schema.define(version: 2021_04_29_021406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "circles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "discographies", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.string "record_label", default: "", null: false
    t.string "apple_music_collection_name", default: "", null: false
    t.string "youtube_collection_name", default: "", null: false
    t.string "youtube_collection_view_url", default: "", null: false
    t.datetime "last_fetched_at", precision: 6
    t.string "spotify_collection_name", default: "", null: false
    t.string "spotify_collection_view_url", default: "", null: false
    t.index ["apple_artist_id"], name: "index_discographies_on_apple_artist_id"
    t.index ["apple_collection_id"], name: "index_discographies_on_apple_collection_id", unique: true
  end

  create_table "discographies_circles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "discographies_id", null: false
    t.uuid "circles_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["circles_id"], name: "index_discographies_circles_on_circles_id"
    t.index ["discographies_id"], name: "index_discographies_circles_on_discographies_id"
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

  create_table "songs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "discography_id", null: false
    t.string "wrapper_type", null: false
    t.string "kind", null: false
    t.bigint "apple_artist_id", null: false
    t.bigint "apple_collection_id", null: false
    t.bigint "apple_track_id", null: false
    t.string "artist_name", null: false
    t.string "collection_name", null: false
    t.string "track_name", null: false
    t.string "collection_censored_name", null: false
    t.string "track_censored_name", null: false
    t.string "artist_view_url", default: "", null: false
    t.text "collection_view_url", null: false
    t.text "track_view_url", null: false
    t.string "preview_url", default: "", null: false
    t.string "artwork_url30", null: false
    t.string "artwork_url60", null: false
    t.string "artwork_url100", null: false
    t.integer "collection_price"
    t.integer "track_price"
    t.datetime "release_date", null: false
    t.string "collection_explicitness", null: false
    t.string "track_explicitness", null: false
    t.integer "disc_count", null: false
    t.integer "disc_number", null: false
    t.integer "track_count", null: false
    t.integer "track_number", null: false
    t.integer "track_time_millis", null: false
    t.string "country", null: false
    t.string "currency", null: false
    t.string "primary_genre_name", null: false
    t.boolean "is_streamable", default: false, null: false
    t.boolean "is_touhou", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "composer_name", default: "", null: false
    t.boolean "has_lyrics", default: false, null: false
    t.string "youtube_collection_name", default: "", null: false
    t.string "youtube_track_name", default: "", null: false
    t.string "youtube_collection_view_url", default: "", null: false
    t.string "youtube_track_view_url", default: "", null: false
    t.string "spotify_collection_name", default: "", null: false
    t.string "spotify_track_name", default: "", null: false
    t.string "spotify_collection_view_url", default: "", null: false
    t.string "spotify_track_view_url", default: "", null: false
    t.index ["apple_artist_id"], name: "index_songs_on_apple_artist_id"
    t.index ["apple_collection_id"], name: "index_songs_on_apple_collection_id"
    t.index ["apple_track_id"], name: "index_songs_on_apple_track_id", unique: true
    t.index ["discography_id"], name: "index_songs_on_discography_id"
  end

  create_table "songs_original_songs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "song_id", null: false
    t.string "original_song_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["original_song_code"], name: "index_songs_original_songs_on_original_song_code"
    t.index ["song_id"], name: "index_songs_original_songs_on_song_id"
  end

  add_foreign_key "discographies_circles", "circles", column: "circles_id"
  add_foreign_key "discographies_circles", "discographies", column: "discographies_id"
  add_foreign_key "songs", "discographies"
  add_foreign_key "songs_original_songs", "songs"
end
