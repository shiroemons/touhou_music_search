class AddRecordLabelToDiscographies < ActiveRecord::Migration[6.1]
  def change
    add_column :discographies, :record_label, :string, null: false, default: ''
  end
end
