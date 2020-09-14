# == Schema Information
#
# Table name: product_eats
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_product_eats_on_product_id              (product_id)
#  index_product_eats_on_user_id                 (user_id)
#  index_product_eats_on_user_id_and_product_id  (user_id,product_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :product_eat do
    association :user, strategy: :create
    association :product, strategy: :create
  end
end
