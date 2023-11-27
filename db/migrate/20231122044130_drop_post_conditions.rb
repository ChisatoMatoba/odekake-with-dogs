class DropPostConditions < ActiveRecord::Migration[7.1]
  def change
    drop_table :post_conditions do |t|
      t.references :post,      null: false, foreign_key: true
      t.references :condition, null: false, foreign_key: true
      t.timestamps
    end
  end
end
