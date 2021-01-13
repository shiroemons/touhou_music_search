class AddAppleMusicCollectionNameToDiscographies < ActiveRecord::Migration[6.1]
  def change
    add_column :discographies, :apple_music_collection_name, :string, null: false, default: ''
  end
end
