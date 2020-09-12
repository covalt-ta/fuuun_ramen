require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.create(:product)}

  describe 'バリデーションのテスト' do
    context '商品の保存ができる場合' do
      it '管理者が紐付いていて全ての項目が必要条件を満たしていると保存される' do
        expect(product).to be_valid
      end
    end

    context '商品の保存ができない場合' do
      it '管理者が紐付いていないと保存できない' do
        product.admin = nil
        product.valid?
        expect(product.errors[:admin]).to include("を入力してください")
      end
      it '画像が空だと保存できない' do
        product.image = nil
        product.valid?
        expect(product.errors[:image]).to include("を入力してください")
      end
      it 'nameが空だと保存できない' do
        product.name = nil
        product.valid?
        expect(product.errors[:name]).to include("を入力してください")
      end
      it 'textが空だと保存できない' do
        product.text = nil
        product.valid?
        expect(product.errors[:text]).to include("を入力してください")
      end
      it 'priceが空だと保存できない' do
        product.price = nil
        product.valid?
        expect(product.errors[:price]).to include("を入力してください")
      end
      it 'priceが100万円以上だと保存できない' do
        product.price = 1000000
        product.valid?
        expect(product.errors[:price]).to include("は999999以下の値にしてください")
      end
      it 'categoryが選択されていないと保存できない' do
        product.category_id = nil
        product.valid?
        expect(product.errors[:category_id]).to include("を入力してください")
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Adminモデルとの関係' do
      it 'N:1となっている' do
        expect(Product.reflect_on_association(:admin).macro).to eq :belongs_to
      end
    end
  end
end
