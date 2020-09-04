# == Schema Information
#
# Table name: contacts
#
#  id           :bigint           not null, primary key
#  email        :string(255)      not null
#  name         :string(255)      not null
#  phone_number :string(255)
#  text         :text(65535)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Contact < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
    validates :text, length: { maximum: 1000 }
  end
end
