FactoryBot.define do
  factory :student do
    name { Faker::Movies::StarWars.character }
    course { nil }
  end
end
