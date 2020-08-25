# == Schema Information
#
# Table name: reservations
#
#  id              :bigint           not null, primary key
#  day             :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  count_person_id :integer
#  time_zone_id    :integer
#  user_id         :bigint
#
# Indexes
#
#  index_reservations_on_count_person_id  (count_person_id)
#  index_reservations_on_day              (day)
#  index_reservations_on_time_zone_id     (time_zone_id)
#  index_reservations_on_user_id          (user_id)
#
class Reservation < ApplicationRecord
  has_many :order_record_products
  has_many :product_toppings, through: :order_record_products
  belongs_to :user, optional: true

  with_options presence: true do
    validates :day
    validates :time_zone_id
    validates :count_person_id, presence: true
  end

  def total_price(product_topping_ids: nil)
    # product_toppingsを引数で渡すから取得している状態で呼び出す
    if product_topping_ids 
      product_toppings = self.product_toppings.where(id: product_topping_ids)
    else
      product_toppings = self.product_toppings
    end

    # productの金額
    product_ids = product_toppings.pluck(:product_id)
    reservation_products = product_ids.map { |id| Product.find(id)}
    product_total_price = reservation_products.sum{|reservation_product| reservation_product[:price]}

    # toppingの金額
    toppings = product_toppings.map(&:toppings)
    topping_total = toppings.map {|topping| topping.sum{|topping| topping[:price]}}
    topping_total_price = topping_total.sum

    product_total_price + topping_total_price
  end
end
