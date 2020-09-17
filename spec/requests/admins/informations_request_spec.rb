require 'rails_helper'

RSpec.describe "Admins::Informations", type: :request do
  let(:admin) { create(:admin) }
  let(:shop) { create(:shop, admin_id: admin.id) }
  let(:information_params) { { information: FactoryBot.attributes_for(:information, admin_id: admin.id) } }
  let(:invalid_information_params) { { information: FactoryBot.attributes_for(:information, title: nil, admin_id: admin.id) } }
  let!(:information) { create(:information, admin_id: admin.id)}

  describe "最新情報の保存 (POST #create)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }
      context '有効な値の場合' do
        it '正常にリクエストを返すこと' do
          post admins_informations_path, params: information_params
          expect(response.status).to eq 302
        end
        it '最新情報が保存されること' do
          expect do
            post admins_informations_path, params: information_params
          end.to change { Information.count }.by(1)
        end
        it '新規登録ページにリダイレクトされること' do
          post admins_informations_path, params: information_params
          expect(response).to redirect_to new_admins_product_path
        end
      end

      context '無効な値の場合' do
        it '最新情報が保存されないこと' do
          expect do
            post admins_informations_path, params: invalid_information_params
          end.to change { Information.count }.by(0)
        end
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post admins_informations_path, params: information_params
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "最新情報の編集画面 (GET #edit)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        get edit_admins_information_path(information)
        expect(response.status).to eq 200
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get edit_admins_information_path(information)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "最新情報の更新 (PUT #update)" do
    let(:update_information_params) { { information: { title: "そこをなんとかよろしくお願いします！"} } }
    let(:invalid_update_information_params) { { information: { title: nil } } }

    context '管理者ログインしている場合' do
      before { sign_in admin }

      context '有効な値の場合' do
        before { put admins_information_path(information), params: update_information_params }

        it '正常にリクエストを返すこと' do
          expect(response.status).to eq 302
        end
        it '更新が成功すること' do
          expect(information.reload.title).to eq 'そこをなんとかよろしくお願いします！'
        end
        it '登録一覧ページにリダイレクトすること' do
          expect(response).to redirect_to admins_products_path
        end
      end

      context '無効な値の場合' do
        before { put admins_information_path(information), params: invalid_update_information_params }

        it '更新が失敗すること' do
          expect(information.reload.title).not_to eq nil
        end
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        put admins_information_path(information), params: update_information_params
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
  describe "最新情報の削除 (DELETE #destroy)" do
    context 'ログインユーザーの場合' do
      before { sign_in admin }

      it '最新情報が削除されること' do
        expect do
          delete admins_information_path(information)
        end.to change { Information.count }.by(-1)
      end
      it '登録一覧ページにリダイレクトすること' do
        delete admins_information_path(information)
        expect(response).to redirect_to admins_products_path
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        delete admins_information_path(information)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
