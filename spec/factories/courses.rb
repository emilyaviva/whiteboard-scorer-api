FactoryBot.define do
  factory :course do
    code { Faker::Lorem.word }
    language { Faker::Lorem.word }
  end
end
