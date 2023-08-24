class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer    :prefecture_id, null: false
      t.string     :place_name,    null: false
      t.integer    :category_id,   null: false
      t.integer    :people_num,    null: false
      t.integer    :dogs_num,      null: false
      t.integer    :rating_id,     null: false
      t.text       :review,        null: false
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
