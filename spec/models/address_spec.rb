# == Schema Information
#
# Table name: addresses
#
#  id            :bigint           not null, primary key
#  block         :string(255)      not null
#  building      :string(255)
#  city          :string(255)      not null
#  phone_number  :string(255)      not null
#  postal_code   :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  prefecture_id :integer          not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_addresses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { FactoryBot.create(:address)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '全ての項目が正しく存在すれば登録できる' do
        expect(address).to be_valid
      end
      it 'buildingが空でも保存ができる' do
        address.building = nil
        expect(address).to be_valid
      end
    end
    context '保存ができない場合' do

      it 'postal_codeが空だと保存できない' do
        address.postal_code = nil
        address.valid?
        expect(address.errors[:postal_code]).to include("を入力してください")
      end
      it 'postal_codeがハイフンが入っていないと保存できない' do
        address.postal_code = '1234567'
        address.valid?
        expect(address.errors[:postal_code]).to include('は不正な値です')
      end
      it 'prefecture_idが選択されていないと保存できない' do
        address.prefecture_id = nil
        address.valid?
        expect(address.errors[:prefecture_id]).to include("を入力してください")
      end
      it 'cityが空だと保存できない' do
        address.city = nil
        address.valid?
        expect(address.errors[:city]).to include('を入力してください')
      end
      it 'cityが空だとアルファベットだと保存できない' do
        address.city = 'shibuya'
        address.valid?
        expect(address.errors[:city]).to include('は不正な値です')
      end
      it 'blockが空だと保存できない' do
        address.block = nil
        address.valid?
        expect(address.errors[:block]).to include("を入力してください")
      end
      it 'blockがアルファベットだと保存できない' do
        address.block = 'roppongi1-1'
        address.valid?
        expect(address.errors[:block]).to include('は不正な値です')
      end
      it 'buildingがアルファベットだと保存できない' do
        address.building = 'Tokiwaso101'
        address.valid?
        expect(address.errors[:building]).to include('は不正な値です')
      end
      it 'phone_numberが空だと保存できない' do
        address.phone_number = nil
        address.valid?
        expect(address.errors[:phone_number]).to include("を入力してください")
      end
      it 'phone_numberにハイフンが入ると保存できない' do
        address.phone_number = '090-12-1221'
        address.valid?
        expect(address.errors[:phone_number]).to include('は不正な値です')
      end
      it 'phone_numberが12桁以上だと保存できない' do
        address.phone_number = '090123456789'
        address.valid?
        expect(address.errors[:phone_number]).to include('は不正な値です')
      end
      it 'user_idが空だと保存できない' do
        address.user = nil
        address.valid?
        expect(address.errors[:user]).to include("を入力してください")
      end
    end
  end
  describe 'アソシエーションのテスト' do
    let(:association) do
      # reflect_on_associationで対象クラスと引数で指定するクラスの関連を返す
      described_class.reflect_on_association(target)
    end
    context 'Userモデルとの関係' do
      let(:target) { :user }
      it 'N:1となっている' do
        expect(association.macro).to eq :belongs_to
      end
      it '関連モデル名はUserとなっている' do
        expect(association.class_name).to eq 'User'
      end
    end
  end
end
