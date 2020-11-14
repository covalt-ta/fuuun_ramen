# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  display     :boolean          default(FALSE)
#  name        :string(255)      not null
#  price       :integer          not null
#  text        :text(65535)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  admin_id    :bigint           not null
#  category_id :integer          not null
#
# Indexes
#
#  index_products_on_admin_id  (admin_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_id => admins.id)
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { FactoryBot.create(:product)}

  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '管理者が紐付いていて全ての項目が必要条件を満たしていると保存できる' do
        expect(product).to be_valid
      end
    end

    context '保存ができない場合' do
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
      it 'nameが41文字以上だと保存できない' do
        product.name = "あ" * 41
        product.valid?
        expect(product.errors[:name]).to include("は40文字以内で入力してください")
      end
      it 'textが空だと保存できない' do
        product.text = nil
        product.valid?
        expect(product.errors[:text]).to include("を入力してください")
      end
      it 'textが1001文字以上だと保存できない' do
        product.text = "あ" * 1001
        product.valid?
        expect(product.errors[:text]).to include("は1000文字以内で入力してください")
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
    let(:association) do
      # reflect_on_associationで対象クラスと引数で指定するクラスの関連を返す
      described_class.reflect_on_association(target)
    end
    context 'Adminモデルとの関係' do
      let(:target) { :admin }
      it 'N:1となっている' do
        expect(association.macro).to eq :belongs_to
      end
      it '関連モデル名はAdminとなっている' do
        expect(association.class_name).to eq 'Admin'
      end
    end
  end
end
