class Post < ApplicationRecord
  belongs_to :user
  has_many   :conditions, through: :post_conditions

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
end
