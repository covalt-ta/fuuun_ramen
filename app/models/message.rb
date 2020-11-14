# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  message    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  admin_id   :bigint
#  room_id    :bigint           not null
#  user_id    :bigint
#
# Indexes
#
#  index_messages_on_admin_id  (admin_id)
#  index_messages_on_room_id   (room_id)
#  index_messages_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (user_id => users.id)
#
class Message < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :admin, optional: true
  belongs_to :room

  validates :message, presence: true
end
