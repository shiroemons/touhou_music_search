class AddHasLyricsToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :has_lyrics, :boolean, null: false, default: false
  end
end
