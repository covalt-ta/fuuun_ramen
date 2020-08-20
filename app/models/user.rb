# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthday               :date             not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  first_name_kana        :string(255)      not null
#  last_name              :string(255)      not null
#  last_name_kana         :string(255)      not null
#  nickname               :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :card, dependent: :destroy
  has_one :basket, dependent: :destroy
  has_one :order_record, dependent: :destroy
  has_one :address, dependent: :destroy
  
  with_options presence: true do
    validates :nickname
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
    validates :birthday
  end

  with_options format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,100}+\z/i } do
    validates :password
    validates :password_confirmation
  end

  with_options format: { with: /\A[ぁ-んァ-ン一-龥]/ } do
    validates :last_name
    validates :first_name
  end

  with_options format: { with: /\A[ァ-ヶー－]+\z/ } do
    validates :last_name_kana
    validates :first_name_kana
  end

  def prepare_basket
    basket || create_basket
  end

  def prepare_order_record
    order_record || create_order_record
  end

  def checkout!(product_ids:,day:, time_zone_id:,count_person_id:) #order_record_id以外のreservationの情報を引数に渡す
    customer_token = card.customer_token
    total_price = basket.total_price(product_ids: product_ids)
    
    transaction do
      # クレジットカード決済
      Charge.create!(total_price, customer_token)

      # order_record_productレコードの作成
      order_record = prepare_order_record
      ids = product_ids.map { |id| { product_id: id}}
      order_record.order_record_products.create!(ids)

      # reservationレコードの作成
      reservation = Reservation.new(day: day, time_zone_id: time_zone_id, count_person_id: count_person_id)
      reservation.order_record_id = order_record.id
      reservation.save!

      # basketレコードの削除
      basket_products = basket.basket_products.where(product_id: product_ids)
      basket_products.each(&:destroy!)
    end
  end
end
