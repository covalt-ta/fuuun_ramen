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
require 'test_helper'

class ProductToppingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
