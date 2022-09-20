FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password: { '123123123' }

    trait :without_email do
      name { Faker::Name.name }
    end
  end
end