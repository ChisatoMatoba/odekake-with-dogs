class Dog < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :dog_name
    validates :dog_birthday
    validates :breed_id
    validates :gender_id
    validates :user
  end
end
