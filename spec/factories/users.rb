FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }

    trait :without_email do
      name { Faker::Name.name }
    end
  end
end