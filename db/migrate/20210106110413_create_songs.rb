class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.references :discography, null: false
      t.string :wrapper_type, null: false
      t.string :kind, null: false
      t.bigint :apple_artist_id, null: false
      t.bigint :apple_collection_id, null: false
      t.bigint :apple_track_id, null: false
      t.string :artist_name, null: false
      t.string :collection_name, null: false
      t.string :track_name, null: false
      t.string :collection_censored_name, null: false
      t.string :track_censored_name, null: false
      t.string :artist_view_url, null: false, default: ''
      t.text :collection_view_url, null: false
      t.text :track_view_url, null: false
      t.string :preview_url, null: false, default: ''
      t.string :artwork_url30, null: false
      t.string :artwork_url60, null: false
      t.string :artwork_url100, null: false
      t.integer :collection_price
      t.integer :track_price
      t.datetime :release_date, null: false
      t.string :collection_explicitness, null: false
      t.string :track_explicitness, null: false
      t.integer :disc_count, null: false
      t.integer :disc_number, null: false
      t.integer :track_count, null: false
      t.integer :track_number, null: false
      t.integer :track_time_millis, null: false
      t.string :country, null: false
      t.string :currency, null: false
      t.string :primary_genre_name, null: false
      t.boolean :is_streamable, null: false, default: false
      t.boolean :is_touhou, null: false, default: true

      t.timestamps
      t.index [:apple_track_id], unique: true
      t.index [:apple_artist_id]
      t.index [:apple_collection_id]
    end
  end
end
