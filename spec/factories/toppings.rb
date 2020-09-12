FactoryBot.define do
  factory :topping do
    name         { Faker::Lorem.word }
    price        { Faker::Number.between(from: 0, to: 999_999) }
    association :admin, strategy: :create
  end
end
