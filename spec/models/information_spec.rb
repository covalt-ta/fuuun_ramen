require 'rails_helper'

RSpec.describe Information, type: :model do
  let(:information) { FactoryBot.create(:information)}
  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(information).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'titleが空の場合、保存できない' do
        information.title = nil
        information.valid?
        expect(information.errors[:title]).to include('を入力してください')
      end
      it 'titleが41文字以上の場合、保存できない' do
        information.title = 'あ' * 41
        information.valid?
        expect(information.errors[:title]).to include('は40文字以内で入力してください')
      end
      it 'textが空の場合、保存できない' do
        information.text = nil
        information.valid?
        expect(information.errors[:text]).to include('を入力してください')
      end
      it 'titleが1001文字以上の場合、保存できない' do
        information.text = 'あ' * 1001
        information.valid?
        expect(information.errors[:text]).to include('は1000文字以内で入力してください')
      end
      it 'Adminが空の場合、保存できない' do
        information.admin = nil
        information.valid?
        expect(information.errors[:admin]).to include('を入力してください')
      end
    end
  end
  describe 'アソシエーションのテスト' do
    let(:association) do
      described_class.reflect_on_association(target)
    end
    context 'Adminモデルとの関係' do
      let(:target) { :admin }
      it 'Adminモデルとの関連付けはbelongs_toであること' do
        expect(association.macro).to eq :belongs_to
      end
    end
  end
end
