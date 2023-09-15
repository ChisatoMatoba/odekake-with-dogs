FactoryBot.define do
  factory :user do
    email                 { Faker::Internet.email }
    password              { 'a1A' + Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    nickname              { Faker::Name.initials(number: 2) }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
