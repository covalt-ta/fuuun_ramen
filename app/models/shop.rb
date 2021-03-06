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
    validates :name, length: { maximum: 40 }
    validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
    validates :open_time_zone_id, numericality: { other_than: 1 }
    validates :close_time_zone_id, numericality: { other_than: 1 }
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/ }
    validates :block, format: { with: /\A[ぁ-んァ-ン一-龥\d]/ }
    validates :phone_number, format: { with: /\A\d{,11}\z/ }
  end
  validates :building, format: { with: /\A[ぁ-んァ-ン一-龥\d]/ }, allow_nil: true, allow_blank: true

  def prefecture
    prefecture = Prefecture.find(prefecture_id)
    prefecture.name
  end

  def address
    self.prefecture + city + block + building
  end

  def open_time
    TimeZone.find(open_time_zone_id).name
  end

  def close_time
    TimeZone.find(close_time_zone_id).name
  end

  def regular_holiday
    week = ["日曜日", "月曜日", "火曜日", "水曜日", "木曜日", "金曜日", "土曜日"]
    week[holiday]
  end
end
