require 'rails_helper'

RSpec.describe OrderRecord, type: :model do
  let(:order_record) { FactoryBot.create(:order_record)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(order_record).to be_valid
      end
    end

    context '保存ができない場合' do
      it 'Userが存在しない' do
        order_record.user = nil
        order_record.valid?
        expect(order_record.errors[:user]).to include('を入力してください')
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

    context 'OrderRecordProductとの関係' do
      let(:target) { :order_record_products }
      it 'OrderRecordProductとの関連付けはhas_manyであること' do
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
