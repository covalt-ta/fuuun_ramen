# == Schema Information
#
# Table name: product_eats
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_product_eats_on_product_id              (product_id)
#  index_product_eats_on_user_id                 (user_id)
#  index_product_eats_on_user_id_and_product_id  (user_id,product_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe ProductEat, type: :model do
  let(:product_eat) { FactoryBot.create(:product_eat)}
  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(product_eat).to be_valid
      end
    end
  end
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context 'Userモデルとの関係' do
      let(:target) { :user }
      it 'Userモデルとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
    context 'Productモデルとの関係' do
      let(:target) { :product }
      it 'Productモデルとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
