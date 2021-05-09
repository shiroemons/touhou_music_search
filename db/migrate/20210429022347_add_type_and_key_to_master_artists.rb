class AddTypeAndKeyToMasterArtists < ActiveRecord::Migration[6.1]
  def up
    add_column :master_artists, :key, :string, null: false, default: ''
    add_column :master_artists, :streaming_type, :string, null: false, default: ''
    remove_column :master_artists, :apple_artist_id
  end

  def down
    add_column :master_artists, :apple_artist_id, :bigint, null: true
    remove_column :master_artists, :streaming_type, :string, null: false, default: ''
    remove_column :master_artists, :key, :string, null: false, default: ''
  end
end
