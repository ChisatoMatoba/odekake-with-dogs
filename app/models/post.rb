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

  # 投稿された地域を分類
  def area_group
    case prefecture_id
    when 2
      ["北海道", "nav-hokkaido-content"]
    when 3..8
      ["東北", "nav-tohoku-content"]
    when 9..15
      ["関東", "nav-tohoku-content"]
    when 16..25
      ["中部", "nav-tohoku-content"]
    when 26..31
      ["近畿", "nav-tohoku-content"]
    when 32..40
      ["中国四国", "nav-tohoku-content"]
    when 41..47
      ["九州", "nav-tohoku-content"]
    when 48
      ["沖縄", "nav-tohoku-content"]
    else
    end
  end

end
