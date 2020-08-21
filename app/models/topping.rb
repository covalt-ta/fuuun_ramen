# == Schema Information
#
# Table name: toppings
#
#  id         :bigint           not null, primary key
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
class Topping < ApplicationRecord
  belongs_to :admin
  has_many :product_toppings, dependent: :destroy
  has_many :products, through: :product_toppings

  with_options presence: true do
    validates :name, length: { maximum: 20 }
    validates :price
  end
end
