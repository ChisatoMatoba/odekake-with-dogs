class RemoveColumnsFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :prefecture_id, :integer
    remove_column :posts, :place_name, :string
    remove_column :posts, :category_id, :integer
  end
end
