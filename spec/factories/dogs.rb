FactoryBot.define do
  factory :dog do
    dog_name      { Faker::Name.initials(number: 2) }
    dog_birthday  { Faker::Date.birthday(max_age: 20) }
    breed         { Breed.find_by(name: 'コーギー(ウェルシュコーギーカーディガン)') }
    gender        { Gender.find_by(name: '男の子♂') }
    association :user

    after(:build) do |dog|
      dog.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
