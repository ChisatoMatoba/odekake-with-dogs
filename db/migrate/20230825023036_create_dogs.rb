class CreateDogs < ActiveRecord::Migration[7.0]
  def change
    create_table :dogs do |t|
      t.string     :dog_name,       null: false
      t.date       :dog_birthday,   null: false
      t.integer    :breed_id,       null: false
      t.integer    :gender_id,      null: false
      t.references :user,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
