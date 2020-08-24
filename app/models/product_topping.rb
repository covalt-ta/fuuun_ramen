# == Schema Information
#
# Table name: product_toppings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#
# Indexes
#
#  index_product_toppings_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class ProductTopping < ApplicationRecord
  belongs_to :product
  has_many :basket_products, dependent: :destroy
  has_many :order_record_products, dependent: :destroy
  has_many :product_topping_relations, dependent: :destroy
  has_many :toppings, through: :product_topping_relations

  def product
    Product.find(product_id)
  end
  
  def topping_names
    names = toppings.map(&:name)
  end

  def get_topping_ids
    toppings.map(&:id)
  end

  def product_topping_price
    product_price = product.price
    toppings_price = toppings.sum(:price)
    product_price + toppings_price
  end
end
