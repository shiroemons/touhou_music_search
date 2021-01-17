class AddYouTubeColumnsToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :youtube_collection_name, :string, null: false, default: ''
    add_column :songs, :youtube_track_name, :string, null: false, default: ''
    add_column :songs, :youtube_collection_view_url, :string, null: false, default: ''
    add_column :songs, :youtube_track_view_url, :string, null: false, default: ''
  end
end
