# == Schema Information
#
# Table name: toppings
#
#  id         :bigint           not null, primary key
#  display    :boolean          default(FALSE)
#  name       :string(255)      not null
#  price      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :bigint           not null
#
# Indexes
#
#  index_toppings_on_admin_id  (admin_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
require 'test_helper'

class ToppingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
