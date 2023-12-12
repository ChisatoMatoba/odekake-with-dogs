FactoryBot.define do
  factory :facility do
    prefecture { Prefecture.find_by(name: '北海道') }
    place_name { Faker::Name.initials(number: 2) }
    category   { Category.find_by(name: '宿泊') }
    association :user
  end
end
