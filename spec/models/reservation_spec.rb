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
require 'rails_helper'

RSpec.describe Reservation, type: :model do
  let(:reservation) { FactoryBot.create(:reservation)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(reservation).to be_valid
      end
      it 'Userが存在していなくても保存できる（ウィザード形式によりフラッシュ使用の為）' do
        reservation.user = nil
        expect(reservation).to be_valid
      end
    end

    context '保存できない場合' do
      it 'dayが存在してないと保存できない' do
        reservation.day = nil
        reservation.valid?
        expect(reservation.errors[:day]).to include('を入力してください')
      end
      it 'time_zone_idが存在してないと保存できない' do
        reservation.time_zone_id = nil
        reservation.valid?
        expect(reservation.errors[:time_zone_id]).to include('を入力してください')
      end
      it 'time_zone_idが「1」を選択していると保存できない' do
        reservation.time_zone_id = "1"
        reservation.valid?
        expect(reservation.errors[:time_zone_id]).to include('は1以外の値にしてください')
      end
      it 'count_person_idが存在してないと保存できない' do
        reservation.count_person_id = nil
        reservation.valid?
        expect(reservation.errors[:count_person_id]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context 'Userモデルとの関係' do
      let(:target) { :user }

      it 'Userモデルとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
    context 'OrderRecordProductモデルとの関係' do
      let(:target) { :order_record_products }

      it 'OrderRecordProductモデルとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
    context 'ProductToppingモデルとの関係' do
      let(:target) { :product_toppings }

      it 'ProductToppingモデルとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
    context 'Noticeモデルとの関係' do
      let(:target) { :notice }

      it 'Noticeモデルとの関連付けはhas_oneであること' do
        expect(association.macro).to eq :has_one
      end
    end
  end
end
