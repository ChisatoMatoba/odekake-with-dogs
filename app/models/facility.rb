class Facility < ApplicationRecord
  belongs_to :user
  has_many :posts

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :prefecture
  belongs_to :category

  serialize :condition_ids, Array

  def conditions
    FacilityCondition.find(condition_ids)
  end

  with_options numericality: { other_than: 1, message: "を入力してください" } do
    validates :prefecture_id
    validates :category_id
  end

  with_options presence: true do
    validates :place_name
  end
end
