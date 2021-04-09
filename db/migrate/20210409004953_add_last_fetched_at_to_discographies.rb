class AddLastFetchedAtToDiscographies < ActiveRecord::Migration[6.1]
  def change
    add_column :discographies, :last_fetched_at, :datetime, limit: 6, null: true
  end
end
