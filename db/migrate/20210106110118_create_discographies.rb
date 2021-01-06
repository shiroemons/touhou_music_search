class CreateDiscographies < ActiveRecord::Migration[6.1]
  def change
    create_table :discographies, id: :uuid do |t|
      t.string :wrapper_type, null: false
      t.string :collection_type, null: false
      t.bigint :apple_artist_id, null: false
      t.bigint :apple_collection_id, null: false
      t.string :artist_name, null: false
      t.string :collection_name, null: false
      t.string :collection_censored_name, null: false
      t.string :artist_view_url, null: false
      t.text :collection_view_url, null: false
      t.string :artwork_url60, null: false
      t.string :artwork_url100, null: false
      t.integer :collection_price
      t.string :collection_explicitness, null: false
      t.integer :track_count, null: false
      t.string :copyright, null: false
      t.string :country, null: false
      t.string :currency, null: false
      t.datetime :release_date, null: false
      t.string :primary_genre_name, null: false
      t.boolean :is_touhou, null: false, default: true

      t.timestamps
      t.index [:apple_collection_id], unique: true
      t.index [:apple_artist_id]
    end
  end
end
