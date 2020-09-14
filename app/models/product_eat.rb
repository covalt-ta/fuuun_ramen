# == Schema Information
#
# Table name: product_eats
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_product_eats_on_product_id              (product_id)
#  index_product_eats_on_user_id                 (user_id)
#  index_product_eats_on_user_id_and_product_id  (user_id,product_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
class ProductEat < ApplicationRecord
  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :product_id, uniqueness: { scope: :user_id }

  belongs_to :user, optional: true
  belongs_to :product, optional: true
end
