require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin) { FactoryBot.build(:admin)}
  describe 'バリデーションのテスト' do
    context 'ユーザー作成ができる場合' do
      it '全ての項目が正しく存在すれば登録できる' do
        expect(admin).to be_valid
      end
    end
  end
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context 'Productモデルとの関係' do
      let(:target) { :products }
      it 'Productモデルとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
    context 'Toppingモデルとの関係' do
      let(:target) { :toppings }
      it 'Toppingモデルとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
    context 'Informationモデルとの関係' do
      let(:target) { :informations }
      it 'Informationモデルとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
    context 'Noticeモデルとの関係' do
      let(:target) { :notices }
      it 'Noticeモデルとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
    context 'Shopモデルとの関係' do
      let(:target) { :shop }
      it 'Shopモデルとの関連付けはhas_oneであること' do
        expect(association.macro).to eq :has_one
      end
    end
  end
end

