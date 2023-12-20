class Tag < ApplicationRecord
  has_many :post_tags, dependent: :delete_all
  has_many :posts, through: :post_tags

  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at id id_value name updated_at]
  end
end
