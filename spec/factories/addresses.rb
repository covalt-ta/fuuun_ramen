# == Schema Information
#
# Table name: addresses
#
#  id            :bigint           not null, primary key
#  block         :string(255)      not null
#  building      :string(255)
#  city          :string(255)      not null
#  phone_number  :string(255)      not null
#  postal_code   :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :integer          not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
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
