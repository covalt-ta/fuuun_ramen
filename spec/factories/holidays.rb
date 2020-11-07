# == Schema Information
#
# Table name: holidays
#
#  id         :bigint           not null, primary key
#  day        :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  shop_id    :bigint           not null
#
# Indexes
#
#  index_holidays_on_shop_id  (shop_id)
#
# Foreign Keys
#
#  fk_rails_...  (shop_id => shops.id)
#
FactoryBot.define do
  factory :holiday do
    day { Faker::Date.forward(days: 30) }
    association :shop, strategy: :create
  end
end
