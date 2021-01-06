class CreateMasterArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :master_artists do |t|
      t.string :name, null: false
      t.bigint :apple_artist_id, null: false

      t.timestamps
    end
  end
end
