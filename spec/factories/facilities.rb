FactoryBot.define do
  factory :facility do
    prefecture { Prefecture.all.sample }
    place_name { Faker::Name.initials(number: 2) }
    category { Category.all.sample }
    association :user
  end
end
