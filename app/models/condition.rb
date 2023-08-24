class Condition < ApplicationRecord
  has_many   :post_conditions
  has_many   :posts, through: :post_conditions
end
