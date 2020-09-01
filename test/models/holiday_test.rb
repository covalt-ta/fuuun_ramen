# == Schema Information
#
# Table name: holidays
#
#  id         :bigint           not null, primary key
#  day        :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  shop_id    :bigint           not null
#
# Indexes
#
#  index_holidays_on_shop_id  (shop_id)
#
# Foreign Keys
#
#  fk_rails_...  (shop_id => shops.id)
#
require 'test_helper'

class HolidayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end