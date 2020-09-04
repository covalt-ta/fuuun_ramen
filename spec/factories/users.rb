# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthday               :date             not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  first_name_kana        :string(255)      not null
#  last_name              :string(255)      not null
#  last_name_kana         :string(255)      not null
#  nickname               :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
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
