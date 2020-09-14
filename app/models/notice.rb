# == Schema Information
#
# Table name: notices
#
#  id             :bigint           not null, primary key
#  action         :string(255)      default(""), not null
#  checked        :boolean          default(FALSE)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  admin_id       :bigint           not null
#  reservation_id :bigint
#
# Indexes
#
#  index_notices_on_admin_id        (admin_id)
#  index_notices_on_reservation_id  (reservation_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#  fk_rails_...  (reservation_id => reservations.id)
#
class Notice < ApplicationRecord
  default_scope -> { order(created_at: :DESC) }
  belongs_to :admin
  belongs_to :reservation

  with_options presence: true do
    validates :action
    validates :admin
    validates :reservation
  end

  def reservation_date
    reservation.day
  end
end
