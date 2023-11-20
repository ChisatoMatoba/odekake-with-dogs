class Condition < ApplicationRecord
  has_many   :facility_conditions
  has_many   :facilities, through: :facility_conditions
end
