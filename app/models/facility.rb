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

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id created_at id id_value place_name prefecture_id updated_at user_id]
  end
end
