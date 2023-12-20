class Condition < ApplicationRecord
  has_many   :facility_conditions
  has_many   :facilities, through: :facility_conditions

  def self.ransackable_attributes(_auth_object = nil)
    %w[category created_at id id_value updated_at]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[facilities facility_conditions]
  end
end
