require 'rails_helper'

RSpec.describe "Cards", type: :request do
  let(:user) { create(:user) }

  describe "クレジットカードの登録画面 (GET #new)" do
    it '正常にリクエストを返すこと' do
      sign_in user
      get new_card_path
      expect(response.status).to eq 200
    end
  end

  describe "クレジットカードの登録 (POST #create)" do
    before do
      sign_in user
      customer = double("Payjp::Customer")
      allow(Payjp::Customer).to receive(:create).and_return(customer)
      allow(customer).to receive(:id).and_return("cus_xxxxxxxxxxx")
    end

    context '有効な値の場合' do
      it '正常にリクエストを返すこと' do
        post cards_path, params: { card_token: "tok_xxxxxxxxxxx" }
        expect(response.status).to eq 302
      end
      it 'カード情報が保存されること' do
        expect do
          post cards_path, params:  { card_token: "tok_xxxxxxxxxxx" }
        end.to change { Card.count }.by(1)
      end
      it 'トップページにリダイレクトされること' do
        post cards_path, params:  { card_token: "tok_xxxxxxxxxxx" }
        expect(response).to redirect_to user_path(user)
      end
    end
  end

  describe "クレジットカードの登録削除 (DELETE #destroy)" do
    let!(:card) { create(:card, user_id: user.id) }

    context 'ログインユーザーの場合' do
      before do
        sign_in user
      end

      it '登録されたクレジットカードが削除されること' do
        expect do
          delete card_path(card)
        end.to change { Card.count }.by(-1)
      end
      it 'ユーザーマイページにリダイレクトすること' do
        delete card_path(card)
        expect(response).to redirect_to user_path(user)
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        delete card_path(card)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
