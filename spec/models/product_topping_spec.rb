require 'rails_helper'

RSpec.describe ProductTopping, type: :model do
  let(:product_topping) { FactoryBot.create(:product_topping)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it 'productと紐づいている' do
        expect(product_topping).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'productと紐づいていない' do
        product_topping.product = nil
        product_topping.valid?
        expect(product_topping.errors[:product]).to include("を入力してください")
      end
    end
  end

  describe 'アソシエーションのテスト' do
    let(:association) do
      # reflect_on_associationで対象クラスと引数で指定するクラスの関連を返す
      described_class.reflect_on_association(target)
    end
    context 'Toppingモデルとの関係' do
      let(:target) { :toppings }
      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
      it '関連モデル名はToppingとなっている' do
        expect(association.class_name).to eq 'Topping'
      end
    end
    context 'ProductToppingRelationモデルとの関係' do
      let(:target) { :product_topping_relations}
      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
      it '関連モデル名はProductToppingRelationとなっている' do
        expect(association.class_name).to eq 'ProductToppingRelation'
      end
    end
  end
end
