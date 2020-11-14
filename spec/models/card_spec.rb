# == Schema Information
#
# Table name: cards
#
#  id             :bigint           not null, primary key
#  card_token     :string(255)      not null
#  customer_token :string(255)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  user_id        :bigint
#
# Indexes
#
#  index_cards_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card) { FactoryBot.create(:card)}
  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(card).to be_valid
      end
    end
  end
  describe 'バリデーションのテスト' do
    context '保存ができない場合' do
      it 'card_tokenが空の場合、保存できない' do
        card.card_token = nil
        card.valid?
        expect(card.errors[:card_token]).to include('を入力してください')
      end
      it 'customer_tokenが空の場合、保存できない' do
        card.customer_token = nil
        card.valid?
        expect(card.errors[:customer_token]).to include('を入力してください')
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
  end
end
