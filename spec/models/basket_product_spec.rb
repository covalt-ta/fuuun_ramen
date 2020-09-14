require 'rails_helper'

RSpec.describe BasketProduct, type: :model do
  let(:basket_product) { FactoryBot.create(:basket_product)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(basket_product).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'Basketが存在していない' do
        basket_product.basket = nil
        basket_product.valid?
        expect(basket_product.errors[:basket]).to include('を入力してください')
      end
      it 'ProductToppingが存在していない' do
        basket_product.product_topping = nil
        basket_product.valid?
        expect(basket_product.errors[:product_topping]).to include('を入力してください')
      end
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end

    context 'Basketとの関係' do
      let(:target) { :basket }
      it 'Basketとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end

    context 'ProductToppingとの関係' do
      let(:target) { :product_topping }
      it 'ProductToppingとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
