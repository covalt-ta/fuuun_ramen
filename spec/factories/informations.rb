FactoryBot.define do
  factory :information do
    title       { Faker::Lorem.word }
    text        { Faker::Lorem.sentence }
    association :admin, strategy: :create
  end
end
