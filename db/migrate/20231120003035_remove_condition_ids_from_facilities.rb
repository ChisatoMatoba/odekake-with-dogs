class RemoveConditionIdsFromFacilities < ActiveRecord::Migration[7.1]
  def change
    remove_column :facilities, :condition_ids
  end
end
