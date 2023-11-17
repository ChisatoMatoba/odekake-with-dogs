class CreateFacilities < ActiveRecord::Migration[7.1]
  def change
    create_table :facilities do |t|
      t.integer    :prefecture_id, null: false
      t.string     :place_name,    null: false
      t.integer    :category_id,   null: false
      t.text       :condition_ids
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
