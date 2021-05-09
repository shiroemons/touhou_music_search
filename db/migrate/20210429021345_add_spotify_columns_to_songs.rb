class AddSpotifyColumnsToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :spotify_collection_name, :string, null: false, default: ''
    add_column :songs, :spotify_track_name, :string, null: false, default: ''
    add_column :songs, :spotify_collection_view_url, :string, null: false, default: ''
    add_column :songs, :spotify_track_view_url, :string, null: false, default: ''
  end
end
