FactoryBot.define do
  factory :post do
    title { Faker::Quote.famous_last_words }
    body { Faker::Quote.matz }
    category
  end
end