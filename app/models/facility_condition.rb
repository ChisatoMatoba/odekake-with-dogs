class FacilityCondition < ApplicationRecord
  belongs_to :facility
  belongs_to :condition
end
