class Facility < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy

  has_many   :facility_conditions, dependent: :destroy
  has_many   :conditions, through: :facility_conditions

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category

  with_options numericality: { only_integer: true, message: 'を入力してください' } do
    validates :prefecture_id
    validates :category_id
  end

  with_options presence: true do
    validates :place_name
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

  # 地域名と都道府県のidを紐づけておく
  def self.area_to_prefecture_ids
    (2..48).each_with_object({}) do |prefecture_id, hash|
      area = new(prefecture_id: prefecture_id).area_group.first
      hash[area] ||= []
      hash[area] << prefecture_id
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id created_at id id_value place_name prefecture_id updated_at user_id]
  end
end
