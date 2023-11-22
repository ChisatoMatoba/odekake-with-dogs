class DropPostConditions < ActiveRecord::Migration[7.1]
  def change
    drop_table :post_conditions
  end
end
