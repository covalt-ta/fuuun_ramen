FactoryBot.define do
  factory :card do
    card_token     { Faker::Lorem.characters(number: 10) }
    customer_token { Faker::Lorem.characters(number: 10) }
    association :user, strategy: :create
  end
end
