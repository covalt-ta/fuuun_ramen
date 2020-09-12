require 'rails_helper'

RSpec.describe Topping, type: :model do
  let(:topping) { FactoryBot.create(:topping)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '管理者が紐付いていて全ての項目が必要条件を満たしていると保存される' do
        expect(topping).to be_valid
      end
    end

    context '商品の保存ができない場合' do
      it '管理者が紐付いていないと保存できない' do
        topping.admin = nil
        topping.valid?
        expect(topping.errors[:admin]).to include("を入力してください")
      end
      it 'nameが空だと保存できない' do
        topping.name = nil
        topping.valid?
        expect(topping.errors[:name]).to include("を入力してください")
      end
      it 'nameが20文字以上だと保存できない' do
        topping.name = "あ" * 21
        topping.valid?
        expect(topping.errors[:name]).to include("は20文字以内で入力してください")
      end
      it 'priceが空だと保存できない' do
        topping.price = nil
        topping.valid?
        expect(topping.errors[:price]).to include("を入力してください")
      end
      it 'priceが100万円以上だと保存できない' do
        topping.price = 1000000
        topping.valid?
        expect(topping.errors[:price]).to include("は999999以下の値にしてください")
      end
    end
  end
  describe 'アソシエーションのテスト' do
    let(:association) do
      # reflect_on_associationで対象クラスと引数で指定するクラスの関連を返す
      described_class.reflect_on_association(target)
    end
    context 'Adminモデルとの関係' do
      let(:target) { :admin }
      it 'N:1となっている' do
        expect(association.macro).to eq :belongs_to
      end
    end
    context 'ProductToppingモデルとの関係' do
      let(:target) { :product_toppings }
      it '1:Nとなっている' do
        expect(association.macro).to eq :has_many
      end
      it '関連モデル名はProductToppingとなっている' do
        expect(association.class_name).to eq 'ProductTopping'
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
