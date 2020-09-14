require 'rails_helper'

RSpec.describe Shop, type: :model do
  let(:shop) { FactoryBot.create(:shop)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(shop).to be_valid
      end
      it 'holidayが空でも保存できる' do
        shop.holiday = nil
        expect(shop).to be_valid
      end
      it 'buildingが空でも保存できる' do
        shop.building = nil
        expect(shop).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'nameが空では保存できない' do
        shop.name = nil
        shop.valid?
        expect(shop.errors[:name]).to include('を入力してください')
      end
      it 'emailが空では保存できない' do
        shop.email = nil
        shop.valid?
        expect(shop.errors[:email]).to include('を入力してください')
      end
      it 'emailに＠が含まれていないと保存できない' do
        shop.email = 'test'
        shop.valid?
        expect(shop.errors[:email]).to include('は不正な値です')
      end
      it 'open_time_zone_idが空だと保存できない' do
        shop.open_time_zone_id = nil
        shop.valid?
        expect(shop.errors[:open_time_zone_id]).to include('を入力してください')
      end
      it 'close_time_zone_idが空だと保存できない' do
        shop.close_time_zone_id = nil
        shop.valid?
        expect(shop.errors[:close_time_zone_id]).to include('を入力してください')
      end
      it 'postal_codeが空だと保存できない' do
        shop.postal_code = nil
        shop.valid?
        expect(shop.errors[:postal_code]).to include("を入力してください")
      end
      it 'postal_codeがハイフンが入っていないと保存できない' do
        shop.postal_code = '1234567'
        shop.valid?
        expect(shop.errors[:postal_code]).to include('は不正な値です')
      end
      it 'prefecture_idが選択されていないと保存できない' do
        shop.prefecture_id = nil
        shop.valid?
        expect(shop.errors[:prefecture_id]).to include("を入力してください")
      end
      it 'cityが空だと保存できない' do
        shop.city = nil
        shop.valid?
        expect(shop.errors[:city]).to include('を入力してください')
      end
      it 'cityが空だとアルファベットだと保存できない' do
        shop.city = 'shibuya'
        shop.valid?
        expect(shop.errors[:city]).to include('は不正な値です')
      end
      it 'blockが空だと保存できない' do
        shop.block = nil
        shop.valid?
        expect(shop.errors[:block]).to include("を入力してください")
      end
      it 'blockがアルファベットだと保存できない' do
        shop.block = 'roppongi1-1'
        shop.valid?
        expect(shop.errors[:block]).to include('は不正な値です')
      end
      it 'buildingがアルファベットだと保存できない' do
        shop.building = 'Tokiwaso101'
        shop.valid?
        expect(shop.errors[:building]).to include('は不正な値です')
      end
      it 'phone_numberが空だと保存できない' do
        shop.phone_number = nil
        shop.valid?
        expect(shop.errors[:phone_number]).to include("を入力してください")
      end
      it 'phone_numberにハイフンが入ると保存できない' do
        shop.phone_number = '090-12-1221'
        shop.valid?
        expect(shop.errors[:phone_number]).to include('は不正な値です')
      end
      it 'phone_numberが12桁以上だと保存できない' do
        shop.phone_number = '090123456789'
        shop.valid?
        expect(shop.errors[:phone_number]).to include('は不正な値です')
      end
      it 'Adminが空だと保存できない' do
        shop.admin = nil
        shop.valid?
        expect(shop.errors[:admin]).to include("を入力してください")
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
    context 'Holidayモデルとの関係' do
      let(:target) { :holidays }
      it 'Holidaysとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
