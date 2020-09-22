require 'rails_helper'

RSpec.describe "Addresses", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "新規作成 (GET #new)" do
    context 'ログインユーザーの場合' do
      before do
        sign_in user
      end
      it '正常にリクエストを返すこと' do
        get new_address_path
        expect(response.status).to eq 200
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get new_address_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '新規登録（POST #create）' do
    let(:address_params) { { address: FactoryBot.attributes_for(:address, user_id: user.id) } }
    let(:invalid_address_params) { { address: FactoryBot.attributes_for(:address, user_id: user.id, postal_code: nil) } }

    context 'ログインしている場合' do
      before do
        sign_in user
      end

      context '有効な属性値の場合' do
        it '新規登録が成功すること' do
          expect do
            post addresses_path, params: address_params
          end.to change { Address.count}.by(1)
        end
        it 'マイページにリダイレクトすること' do
          post addresses_path, params: address_params
          expect(response).to redirect_to user_path(user)
        end
      end

      context '無効な属性値の場合' do
        it '新規登録が成功しないこと' do
          expect do
            post addresses_path, params: invalid_address_params
          end.to change { Address.count}.by(0)
        end
        it '住所登録ページにリダイレクトすること' do
          post addresses_path, params: invalid_address_params
          expect(response).to redirect_to new_address_path
        end
      end

    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        post addresses_path, params: address_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '住所情報の更新（PUT #update）' do
    let(:address) { FactoryBot.create(:address, city: "六本木", user_id: user.id) }
    let(:address_params) { { address: {city: "渋谷" }} }
    let(:invalid_address_params) { { address: {city: nil }} }

    context 'ログインユーザーの場合' do
      context '有効な属性値の場合' do
        before do
          sign_in user
          put address_path(address), params: address_params
        end
        it 'リクエストが成功すること' do
          expect(response.status).to eq 302
        end
        it '更新が成功すること' do
          expect(address.reload.city).to eq '渋谷'
        end
        it 'マイページにリダイレクトすること' do
          expect(response).to redirect_to user_path(user)
        end
      end

      context '無効な属性値の場合' do
        before do
          sign_in user
          put address_path(address), params: invalid_address_params
        end
        it '更新が失敗すること' do
          expect(address.reload.city).to eq '六本木'
        end
        it 'マイページにリダイレクトすること' do
          expect(response).to redirect_to user_path(user)
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        put address_path(address), params: address_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe '住所情報の削除（DELETE #destroy）' do
    let!(:address) { FactoryBot.create(:address, user_id: user.id) }
    context 'ログインユーザーの場合' do
      before do
        sign_in user
      end
      it '住所情報が削除されること' do
        expect do
          delete address_path(address)
        end.to change { Address.count }.by(-1)
      end
      it 'マイページにリダイレクトすること' do
        delete address_path(address)
        expect(response).to redirect_to user_path(user)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトすること' do
        delete address_path(address)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
