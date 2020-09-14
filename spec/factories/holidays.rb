FactoryBot.define do
  factory :holiday do
    day { Faker::Date.forward(days: 30) }
    association :shop, strategy: :create
  end
end
