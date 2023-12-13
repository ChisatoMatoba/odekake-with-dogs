FactoryBot.define do
  factory :facility do
    prefecture { Prefecture.all.reject { |p| p.id == 1 }.sample }
    place_name { Faker::Name.initials(number: 2) }
    category { Category.all.reject { |p| p.id == 1 }.sample }
    association :user
  end
end
