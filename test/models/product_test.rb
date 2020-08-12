# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  price       :integer          not null
#  text        :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  admin_id    :bigint           not null
#  category_id :integer          not null
#
# Indexes
#
#  index_products_on_admin_id  (admin_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
