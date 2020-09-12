require 'rails_helper'

RSpec.describe Admin, type: :model do
  let(:admin) { FactoryBot.build(:admin)}

  describe 'バリデーションのテスト' do
    context 'ユーザー作成ができる場合' do
      it '全ての項目が正しく存在すれば登録できる' do
        expect(admin).to be_valid
      end
    end
  end
end

