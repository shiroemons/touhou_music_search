class CreateOdesliAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table :odesli_albums, id: :uuid do |t|
      t.references :discography, type: :uuid, null: false, foreign_key: true
      t.jsonb :payload, null: false
      t.datetime :fetched_at, null: false, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end
