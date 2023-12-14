class Dog < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :dog_name
    validates :dog_birthday
    validates :breed_id,         numericality: { only_integer: true, message: 'を入力してください' }
    validates :gender_id,        numericality: { only_integer: true, message: 'を入力してください' }
    validates :image
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :breed
  belongs_to :gender
end
