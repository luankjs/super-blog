FactoryBot.define do
  factory :post do
    title { Faker::Quote.famous_last_words }
    body { Faker::Quote.matz }
    category

    trait :with_comments do
      comments { build_list :comment, 3 }
    end
  end
end