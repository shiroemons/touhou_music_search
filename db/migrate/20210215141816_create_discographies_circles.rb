class CreateDiscographiesCircles < ActiveRecord::Migration[6.1]
  def change
    create_table :discographies_circles, id: :uuid do |t|
      t.references :discographies, type: :uuid, null: false, foreign_key: true
      t.references :circles, type: :uuid, null: false, foreign_key: true
      t.timestamps
    end
  end
end
