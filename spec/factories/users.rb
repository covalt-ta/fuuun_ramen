FactoryBot.define do
  factory :user do
    nickname               { Faker::Name.initials(number: 4) }
    email                  { Faker::Internet.free_email }
    password               { Faker::Lorem.characters(number: 6, min_alpha: 4, min_numeric: 2) }
    password_confirmation  { password }
    last_name              { Gimei.last.kanji }
    first_name             { Gimei.first.kanji }
    last_name_kana         { Gimei.last.katakana }
    first_name_kana        { Gimei.first.katakana }
    birthday               { Faker::Date.birthday(min_age: 12, max_age: 80) }
  end
end
