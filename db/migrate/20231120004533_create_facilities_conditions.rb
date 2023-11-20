class CreateFacilitiesConditions < ActiveRecord::Migration[7.1]
  def change
    create_table :facilities_conditions do |t|
      t.references :facility, null: false, foreign_key: true
      t.references :condition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
