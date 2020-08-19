# == Schema Information
#
# Table name: addresses
#
#  id            :bigint           not null, primary key
#  block         :string(255)      not null
#  building      :string(255)
#  city          :string(255)      not null
#  phone_number  :string(255)      not null
#  postal_code   :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :integer          not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :block, format: { with: /\A[ぁ-んァ-ン一-龥\d]/ }
    validates :phone_number, format: { with: /\A\d{,11}\z/ }
    validates :user_id
  end

  validates :building, format: { with: /\A[ぁ-んァ-ン一-龥\d]/ }, allow_nil: true, allow_blank: true

end
