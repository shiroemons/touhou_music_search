class AddAmazonColumnsToDiscographies < ActiveRecord::Migration[6.1]
  def change
    add_column :discographies, :amazon_music_collection_name, :string, null: false, default: ''
    add_column :discographies, :amazon_music_collection_view_url, :string, null: false, default: ''
    add_column :discographies, :amazon_store_collection_view_url, :string, null: false, default: ''
  end
end
