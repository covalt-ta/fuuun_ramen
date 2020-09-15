require 'rails_helper'

RSpec.describe "Baskets", type: :request do
  let(:user) { create(:user) }

  describe "買い物かご (GET #show)" do
    context 'ログインユーザーの場合' do
      before do
        sign_in user
      end
      it "正常にリクエストを返すこと" do
        get basket_path
        expect(response).to have_http_status(200)
      end
    end

    context 'ログインしていない場合' do
      it "ログインページにリダイレクトされること" do
        get basket_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
