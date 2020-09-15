require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "マイページページ(GET #show)" do
    context 'ログインユーザーの場合' do
      before do
        sign_in user
      end
      context '本人の場合' do
        it "正常にリクエストを返すこと" do
          get user_path(user)
          expect(response.status).to eq 200
        end
      end
      context '他のユーザーの場合' do
        it 'リダイレクトされること' do
          get user_path(other_user)
          expect(response).to redirect_to root_path
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get user_path(user)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  describe "ユーザー情報の更新(PUT #update)" do
    let(:params) { { user: { nickname: "カエサル" } } }

    context 'ログインユーザーの場合' do
      before do
        sign_in user
        put user_path(user.id), params: params
      end

      it 'リクエストが成功すること' do
        expect(response.status).to eq 302
      end
      it '更新が成功すること' do
        expect(user.reload.nickname).to eq 'カエサル'
      end
      it 'マイページにリダイレクトすること' do
        expect(response).to redirect_to user_path(user)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        put user_path(user.id), params: params
        expect(response).to redirect_to new_user_session_path
      end
    end
    context '他のユーザーの場合' do
      it 'root_pathへリダイレクトすること' do
        sign_in other_user
        put user_path(user.id), params: params
        expect(response).to redirect_to redirect_to root_path
      end
    end
  end
end
