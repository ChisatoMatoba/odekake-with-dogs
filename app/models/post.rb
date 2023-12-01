class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :facility

  has_many_attached :images

  has_many :post_tags, dependent: :delete_all
  has_many :tags, through: :post_tags
  # allow_destroy: 空欄の場合削除できるようにする
  accepts_nested_attributes_for :tags, allow_destroy: true

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :rating

  with_options numericality: { other_than: 1, message: 'を入力してください' } do
    validates :rating_id
  end

  with_options presence: true do
    validates :people_num
    validates :dogs_num
    validates :review
    validates :images, length: { minimum: 1, maximum: 5, message: 'は1枚以上5枚以下にしてください' }
  end
end
