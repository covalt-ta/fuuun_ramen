# == Schema Information
#
# Table name: product_toppings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  topping_id :bigint           not null
#
# Indexes
#
#  index_product_toppings_on_product_id  (product_id)
#  index_product_toppings_on_topping_id  (topping_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (topping_id => toppings.id)
#
FactoryBot.define do
  factory :product_topping do
    
  end
end
