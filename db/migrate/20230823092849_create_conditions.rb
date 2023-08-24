class CreateConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :conditions do |t|
      t.string :category
      t.timestamps
    end
  end
end
