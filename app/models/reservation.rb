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
  belongs_to :user, optional: true
  has_one :notice, dependent: :destroy
  has_many :order_record_products
  has_many :product_toppings, through: :order_record_products

  with_options presence: true do
    validates :day
    validates :time_zone_id, numericality: { other_than: 1 }
    validates :count_person_id
  end

  validate :day_not_before_today

  def day_not_before_today
    errors.add(:day, "ご予約日は今日以降を選択してください") if day.nil? || day < Date.today
  end

  def get_time_zone
    TimeZone.find(time_zone_id).name
  end

  def get_count_person
    CountPerson.find(count_person_id).name
  end

  def get_count_person_value
    CountPerson.find(count_person_id).value
  end

  def get_product_toppings
    order_record_products.map {|order_record_product| "#{order_record_product.product_topping.product.name} <#{order_record_product.product_topping.topping_names}>"}
  end

  def total_price(product_topping_ids: nil)
    # product_toppingsを引数で渡すから取得している状態で呼び出す
    product_toppings = product_topping_ids ? self.product_toppings.where(id: product_topping_ids) : self.product_toppings
    PriceCalculator.total(product_toppings)
  end
end
