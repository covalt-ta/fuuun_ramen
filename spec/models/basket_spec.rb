require 'rails_helper'

RSpec.describe Basket, type: :model do
  let(:basket) { FactoryBot.create(:basket)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(basket).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'Userが存在しない' do
        basket.user = nil
        basket.valid?
        expect(basket.errors[:user]).to include('を入力してください')
      end
    end
  end
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Userとの関係' do
      let(:target) { :user }
      it 'Userとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'BasketProductとの関係' do
      let(:target) { :basket_products }
      it 'BasketProductとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end

    context 'ProductToppingとの関係' do
      let(:target) { :product_toppings }
      it 'ProductToppingとの関連付けはhas_manyであること' do
        expect(association.macro).to eq :has_many
      end
    end
  end
end
