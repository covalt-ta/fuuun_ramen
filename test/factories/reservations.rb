# == Schema Information
#
# Table name: reservations
#
#  id              :bigint           not null, primary key
#  day             :date
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  count_person_id :integer
#  time_zone_id    :integer
#  user_id         :bigint
#
# Indexes
#
#  index_reservations_on_count_person_id  (count_person_id)
#  index_reservations_on_day              (day)
#  index_reservations_on_time_zone_id     (time_zone_id)
#  index_reservations_on_user_id          (user_id)
#
FactoryBot.define do
  factory :reservation do
    
  end
end
