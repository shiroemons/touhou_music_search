class AddAmazonColumnsToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :amazon_music_collection_name, :string, null: false, default: ''
    add_column :songs, :amazon_music_track_name, :string, null: false, default: ''
    add_column :songs, :amazon_music_collection_view_url, :string, null: false, default: ''
    add_column :songs, :amazon_store_collection_view_url, :string, null: false, default: ''
    add_column :songs, :amazon_music_track_view_url, :string, null: false, default: ''
  end
end
