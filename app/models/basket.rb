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
    # 購入画面の場合、paramsにあるproduct_topping_idsによって合計金額を算出する
    product_toppings = product_topping_ids ? self.product_toppings.where(id: product_topping_ids) : self.product_toppings
    PriceCalculator.total(product_toppings)
  end
end
