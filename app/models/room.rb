# == Schema Information
#
# Table name: rooms
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reservation_id :bigint           not null
#
# Indexes
#
#  index_rooms_on_reservation_id  (reservation_id)
#
# Foreign Keys
#
#  fk_rails_...  (reservation_id => reservations.id)
#
class Room < ApplicationRecord
  belongs_to :reservation
  has_many :messages, dependent: :destroy

  validates :reservation_id, uniqueness: true
end
