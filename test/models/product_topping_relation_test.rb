# == Schema Information
#
# Table name: product_topping_relations
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_topping_id :bigint           not null
#  topping_id         :bigint           not null
#
# Indexes
#
#  index_product_topping_relations_on_product_topping_id  (product_topping_id)
#  index_product_topping_relations_on_topping_id          (topping_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_topping_id => product_toppings.id)
#  fk_rails_...  (topping_id => toppings.id)
#
require 'test_helper'

class ProductToppingRelationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
