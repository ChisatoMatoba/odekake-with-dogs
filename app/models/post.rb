class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :facility

  has_many   :post_conditions, dependent: :destroy
  has_many   :conditions, through: :post_conditions
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category
  belongs_to :rating

  with_options numericality: { other_than: 1, message: 'を入力してください' } do
    validates :prefecture_id
    validates :category_id
    validates :rating_id
  end

  with_options presence: true do
    validates :place_name
    validates :people_num
    validates :dogs_num
    validates :review
    validates :images, length: { minimum: 1, maximum: 5, message: 'は1枚以上5枚以下にしてください' }
  end

  # 投稿された地域を分類
  def area_group
    case prefecture_id
    when 2
      %w[北海道 nav-hokkaido-content nav-hokkaido-tab]
    when 3..8
      %w[東北 nav-tohoku-content nav-tohoku-tab]
    when 9..15
      %w[関東 nav-kanto-content nav-kanto-tab]
    when 16..25
      %w[中部 nav-chubu-content nav-chubu-tab]
    when 26..31
      %w[近畿 nav-kinki-content nav-kinki-tab]
    when 32..40
      %w[中国四国 nav-chushikoku-content nav-chushikoku-tab]
    when 41..47
      %w[九州 nav-kyushu-content nav-kyushu-tab]
    when 48
      %w[沖縄 nav-okinawa-content nav-okinawa-tab]
    end
  end
end
