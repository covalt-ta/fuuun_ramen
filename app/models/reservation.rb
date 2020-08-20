# == Schema Information
#
# Table name: reservations
#
#  id              :bigint           not null, primary key
#  day             :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  count_person_id :integer
#  order_record_id :bigint
#  time_zone_id    :integer
#
# Indexes
#
#  index_reservations_on_count_person_id  (count_person_id)
#  index_reservations_on_day              (day)
#  index_reservations_on_order_record_id  (order_record_id)
#  index_reservations_on_time_zone_id     (time_zone_id)
#
class Reservation < ApplicationRecord
  belongs_to :order_record, optional: true
  validates :day, :time_zone_id, :count_person_id, presence: true
end
