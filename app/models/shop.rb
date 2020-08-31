# == Schema Information
#
# Table name: shops
#
#  id                 :bigint           not null, primary key
#  block              :string(255)      not null
#  building           :string(255)
#  city               :string(255)      not null
#  email              :string(255)      not null
#  holiday            :integer
#  name               :string(255)      not null
#  phone_number       :string(255)      not null
#  postal_code        :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  admin_id           :bigint           not null
#  close_time_zone_id :integer          not null
#  open_time_zone_id  :integer          not null
#  prefecture_id      :integer          not null
#
# Indexes
#
#  index_shops_on_admin_id  (admin_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
class Shop < ApplicationRecord
  belongs_to :admin
  has_many :holidays

  with_options presence: true do
    validates :name
    validates :email
    validates :open_time_zone_id
    validates :close_time_zone_id
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :block, format: { with: /\A[ぁ-んァ-ン一-龥\d]/ }
    validates :phone_number, format: { with: /\A\d{,11}\z/ }
    validates :admin_id
  end
  validates :building, format: { with: /\A[ぁ-んァ-ン一-龥\d]/ }, allow_nil: true, allow_blank: true
end
