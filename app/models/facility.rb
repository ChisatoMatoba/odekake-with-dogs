class Facility < ApplicationRecord
  belongs_to :user
  has_many :posts

  has_many   :facility_conditions, dependent: :destroy
  has_many   :conditions, through: :facility_conditions

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category

  with_options numericality: { other_than: 1, message: "を入力してください" } do
    validates :prefecture_id
    validates :category_id
  end

  with_options presence: true do
    validates :place_name
  end
end
