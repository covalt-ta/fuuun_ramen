# == Schema Information
#
# Table name: cards
#
#  id             :bigint           not null, primary key
#  card_token     :string(255)      not null
#  customer_token :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :card do
    card_token     { Faker::Lorem.characters(number: 10) }
    customer_token { Faker::Lorem.characters(number: 10) }
    association :user, strategy: :create
  end
end
