# == Schema Information
#
# Table name: baskets
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_baskets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Basket < ApplicationRecord
  belongs_to :user
  has_many :basket_products, dependent: :destroy
  has_many :product_toppings, through: :basket_products

  def total_price(product_topping_ids: nil)
    # product_toppingsを引数で渡すから取得している状態で呼び出す
    product_toppings = if product_topping_ids
                         self.product_toppings.where(id: product_topping_ids)
                       else
                         self.product_toppings
                       end

    # productの金額
    product_ids = product_toppings.pluck(:product_id)
    basket_products = product_ids.map { |id| Product.find(id) }
    product_total_price = basket_products.sum { |basuket_product| basuket_product[:price] }

    # toppingの金額
    toppings = product_toppings.map(&:toppings)
    topping_total = toppings.map { |topping| topping.sum { |topping| topping[:price] } }
    topping_total_price = topping_total.sum

    product_total_price + topping_total_price
  end
end
