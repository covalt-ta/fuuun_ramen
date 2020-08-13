# == Schema Information
#
# Table name: cards
#
#  id             :bigint           not null, primary key
#  card_token     :string(255)      not null
#  customer_token :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Card < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :card_token
    validates :customer_token
    validates :user_id
  end

end
