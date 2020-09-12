require 'rails_helper'

RSpec.describe ProductToppingRelation, type: :model do
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context 'ProductToppingモデルとの関係' do
      let(:target) { :product_topping }
      it 'N:1の関係になっている' do
        expect(association.macro).to eq :belongs_to
      end
      it '関連モデル名はProductToppingとなっている' do
        expect(association.class_name).to eq 'ProductTopping'
      end
    end
    context 'Toppingモデルとの関係' do
      let(:target) { :topping }
      it 'N:1の関係になっている' do
        expect(association.macro).to eq :belongs_to
      end
      it '関連モデルはToppingとなっている' do
        expect(association.class_name).to eq 'Topping'
      end
    end

  end
end
