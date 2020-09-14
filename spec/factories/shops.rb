FactoryBot.define do
  factory :shop do
    name                   { Faker::Lorem.word }
    email                  { Faker::Internet.free_email }
    open_time_zone_id      { '5' }
    close_time_zone_id     { '30' }
    holiday                { '1' }
    postal_code            { '123-4567' }
    prefecture_id          { Faker::Number.within(range: 2..48) }
    city                   { Gimei.address.city.kanji }
    block                  { Gimei.address.town.kanji }
    building               { 'トキワ荘101' }
    phone_number           { Faker::Number.leading_zero_number(digits: 10) }
    association :admin, strategy: :create
  end
end
