FactoryBot.define do
  factory :reservation do
    day            { Faker::Date.forward(days: 30) }
    count_person_id { Faker::Number.within(range: 1..11) }
    time_zone_id    { Faker::Number.within(range: 2..33) }
    association :user, strategy: :create
  end
end
