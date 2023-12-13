FactoryBot.define do
  factory :facility do
    prefecture { Prefecture.where.not(id: 1).sample }
    place_name { Faker::Name.initials(number: 2) }
    category { Category.where.not(id: 1).sample }
    association :user
  end
end
