class AddComposerNameToSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :composer_name, :string, null: false, default: ''
  end
end
