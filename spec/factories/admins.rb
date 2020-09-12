FactoryBot.define do
  factory :admin do
    name                   { Faker::Name.initials(number: 4) }
    email                  { Faker::Internet.free_email }
    password               { Faker::Lorem.characters(number: 6, min_alpha: 4, min_numeric: 2) }
    password_confirmation  { password }
  end
end
