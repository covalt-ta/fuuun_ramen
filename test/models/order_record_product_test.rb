# == Schema Information
#
# Table name: order_record_products
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  order_record_id :bigint           not null
#  product_id      :bigint           not null
#
# Indexes
#
#  index_order_record_products_on_order_record_id  (order_record_id)
#  index_order_record_products_on_product_id       (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_record_id => order_records.id)
#  fk_rails_...  (product_id => products.id)
#
require 'test_helper'

class OrderRecordProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
