# == Schema Information
#
# Table name: order_record_products
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  order_record_id    :bigint           not null
#  product_topping_id :bigint           not null
#  reservation_id     :bigint           not null
#
# Indexes
#
#  index_order_record_products_on_order_record_id     (order_record_id)
#  index_order_record_products_on_product_topping_id  (product_topping_id)
#  index_order_record_products_on_reservation_id      (reservation_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_record_id => order_records.id)
#  fk_rails_...  (product_topping_id => product_toppings.id)
#  fk_rails_...  (reservation_id => reservations.id)
#
require 'rails_helper'

RSpec.describe OrderRecordProduct, type: :model do
  let(:order_record_product) { FactoryBot.create(:order_record_product)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(order_record_product).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'ProductToppingが存在しないと保存できない' do
        order_record_product.product_topping = nil
        order_record_product.valid?
        expect(order_record_product.errors[:product_topping]).to include 'を入力してください'
      end
      it 'OrderRecordが存在しないと保存できない' do
        order_record_product.order_record = nil
        order_record_product.valid?
        expect(order_record_product.errors[:order_record]).to include 'を入力してください'
      end
      it 'Reservationが存在しないと保存できない' do
        order_record_product.reservation = nil
        order_record_product.valid?
        expect(order_record_product.errors[:reservation]).to include 'を入力してください'
      end
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context 'ProductToppingモデルとの関係' do
      let(:target) { :product_topping }

      it 'ProductToppingモデルとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
    context 'OrderRecordモデルとの関係' do
      let(:target) { :order_record }

      it 'OrderRecordモデルとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
    context 'Reservationモデルとの関係' do
      let(:target) { :reservation }

      it 'Reservationモデルとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
