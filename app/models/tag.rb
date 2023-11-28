class Tag < ApplicationRecord
  has_many :post_tags, dependent: :delete_all
  has_many :posts, through: :post_tags
end
