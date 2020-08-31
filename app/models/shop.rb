# == Schema Information
#
# Table name: shops
#
#  id                 :bigint           not null, primary key
#  block              :string(255)      not null
#  building           :string(255)
#  city               :string(255)      not null
#  email              :string(255)      not null
#  name               :string(255)      not null
#  phone_number       :string(255)      not null
#  postal_code        :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  admin_id           :bigint           not null
#  close_time_zone_id :integer          not null
#  holiday_id         :integer
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
end
