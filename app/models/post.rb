class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many   :post_conditions, dependent: :destroy
  has_many   :conditions, through: :post_conditions
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category
  belongs_to :rating

  with_options numericality: { other_than: 1, message: "を入力してください" } do
    validates :prefecture_id
    validates :category_id
    validates :rating_id
  end

  with_options presence: true do
    validates :place_name
    validates :people_num
    validates :dogs_num
    validates :review
    validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
  end

end
