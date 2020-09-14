FactoryBot.define do
  factory :address do
    postal_code            { '123-4567' }
    prefecture_id          { Faker::Number.within(range: 2..48) }
    city                   { Gimei.address.city.kanji }
    block                  { Gimei.address.town.kanji }
    building               { 'トキワ荘101' }
    phone_number           { Faker::Number.leading_zero_number(digits: 10) }
    association :user, strategy: :create
  end
end
