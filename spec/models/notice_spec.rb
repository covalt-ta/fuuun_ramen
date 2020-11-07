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
require 'rails_helper'

RSpec.describe Notice, type: :model do
  let(:notice) { FactoryBot.create(:notice)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(notice).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'actionが空の場合、保存できない' do
        notice.action = nil
        notice.valid?
        expect(notice.errors[:action]).to include("を入力してください")
      end

      it 'Adminが空の場合、保存できない' do
        notice.admin = nil
        notice.valid?
        expect(notice.errors[:admin]).to include("を入力してください")
      end

      it 'Reservationが空の場合、保存できない' do
        notice.reservation = nil
        notice.valid?
        expect(notice.errors[:reservation]).to include("を入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context 'Adminモデルとの関係' do
      let(:target) { :admin }

      it 'Adminモデルとの関連付けはbelongs_toであること' do
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
