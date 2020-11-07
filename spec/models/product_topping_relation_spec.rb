# == Schema Information
#
# Table name: product_topping_relations
#
#  id                 :bigint           not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  product_topping_id :bigint
#  topping_id         :bigint
#
# Indexes
#
#  index_product_topping_relations_on_product_topping_id  (product_topping_id)
#  index_product_topping_relations_on_topping_id          (topping_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_topping_id => product_toppings.id)
#  fk_rails_...  (topping_id => toppings.id)
#
require 'rails_helper'

RSpec.describe ProductToppingRelation, type: :model do
  describe 'バリデーションのテスト' do
    let(:product_topping_relation) { FactoryBot.create(:product_topping_relation)}

    context '保存ができる場合' do
      it 'ProductToppingとToppingが存在すること' do
        expect(product_topping_relation).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'ProductToppingが存在しない' do
        product_topping_relation.product_topping = nil
        product_topping_relation.valid?
        expect(product_topping_relation.errors[:product_topping]).to include("を入力してください")
      end
      it 'Toppingが存在しない' do
        product_topping_relation.topping = nil
        product_topping_relation.valid?
        expect(product_topping_relation.errors[:topping]).to include("を入力してください")
      end
    end
  end
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
