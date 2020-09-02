# == Schema Information
#
# Table name: basket_products
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  basket_id          :bigint           not null
#  product_topping_id :bigint           not null
#
# Indexes
#
#  index_basket_products_on_basket_id           (basket_id)
#  index_basket_products_on_product_topping_id  (product_topping_id)
#
# Foreign Keys
#
#  fk_rails_...  (basket_id => baskets.id)
#  fk_rails_...  (product_topping_id => product_toppings.id)
#
FactoryBot.define do
  factory :basket_product do
  end
end
