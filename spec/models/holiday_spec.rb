require 'rails_helper'

RSpec.describe Holiday, type: :model do
  let(:holiday) { FactoryBot.create(:holiday)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(holiday).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'dayが空の場合、保存できない' do
        holiday.day = nil
        holiday.valid?
        expect(holiday.errors[:day]).to include('を入力してください')
      end

      it 'dayが重複している場合、保存できない' do
        holiday_second = FactoryBot.build(:holiday)
        holiday_second.day = holiday.day
        holiday_second.valid?
        expect(holiday_second.errors[:day]).to include('はすでに存在します')
      end

      it 'Shopが空の場合、保存できない' do
        holiday.shop = nil
        holiday.valid?
        expect(holiday.errors[:shop]).to include('を入力してください')
      end
    end
  end
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context 'Shopモデルとの関係' do
      let(:target) { :shop }
      it 'Shopモデルとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
