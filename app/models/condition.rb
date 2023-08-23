class Condition < ApplicationRecord
  has_many   :posts, through: :post_conditions
end
