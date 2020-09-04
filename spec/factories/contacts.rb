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
FactoryBot.define do
  factory :contact do
    
  end
end
