# == Schema Information
#
# Table name: order_record_products
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  order_record_id    :bigint           not null
#  product_topping_id :bigint           not null
#  reservation_id     :bigint           not null
#
# Indexes
#
#  index_order_record_products_on_order_record_id     (order_record_id)
#  index_order_record_products_on_product_topping_id  (product_topping_id)
#  index_order_record_products_on_reservation_id      (reservation_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_record_id => order_records.id)
#  fk_rails_...  (product_topping_id => product_toppings.id)
#  fk_rails_...  (reservation_id => reservations.id)
#
FactoryBot.define do
  factory :order_record_product do
    
  end
end
