# == Schema Information
#
# Table name: information
#
#  id         :bigint           not null, primary key
#  text       :text(65535)      not null
#  title      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :bigint           not null
#
# Indexes
#
#  index_information_on_admin_id  (admin_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
require 'test_helper'

class InformationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
