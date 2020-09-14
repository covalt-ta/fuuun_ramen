# == Schema Information
#
# Table name: order_records
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_order_records_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class OrderRecord < ApplicationRecord
  belongs_to :user
  has_many :order_record_products, dependent: :destroy
  has_many :product_toppings, through: :order_redord_products
end
