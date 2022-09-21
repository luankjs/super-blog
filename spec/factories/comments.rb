FactoryBot.define do
  factory :comment do
    text { Faker::Quote.famous_last_words }
    author_name { Faker::Name.name }
    author_email { Faker::Internet.email }
    article
  end
end