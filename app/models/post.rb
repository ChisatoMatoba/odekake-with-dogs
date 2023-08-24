class Post < ApplicationRecord
  belongs_to :user
  has_many   :post_conditions
  has_many   :conditions, through: :post_conditions
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category
  belongs_to :rating
end
