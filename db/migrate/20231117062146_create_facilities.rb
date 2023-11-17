class CreateFacilities < ActiveRecord::Migration[7.1]
  def change
    create_table :facilities do |t|

      t.timestamps
    end
  end
end
