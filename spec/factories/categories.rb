FactoryBot.define do
  factory :category do
    name { Faker::Computer.platform }
  end
end