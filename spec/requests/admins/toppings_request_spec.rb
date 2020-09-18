require 'rails_helper'

RSpec.describe "Admins::Informations", type: :request do
  let(:admin) { create(:admin) }
  let!(:topping) { create(:topping) }
  let(:topping_params) { { topping: FactoryBot.attributes_for(:topping, admin_id: admin.id) } }
  let(:invalid_topping_params) { { topping: FactoryBot.attributes_for(:topping, name: nil, admin_id: admin.id) } }

  describe "商品の保存 (POST #create)" do
    context '管理者ログインしている場合' do
      before do
        sign_in admin
      end
      context '有効な値の場合' do
        it '正常にリクエストを返すこと' do
          post admins_toppings_path, params: topping_params
          expect(response.status).to eq 302
        end
        it 'トッピング情報が保存されること' do
          expect do
            post admins_toppings_path, params: topping_params
          end.to change { Topping.count }.by(1)
        end
        it '新規登録ページにリダイレクトされること' do
          post admins_toppings_path, params: topping_params
          expect(response).to redirect_to new_admins_product_path
        end
      end

      context '無効な値の場合' do
        it '最新情報が保存されないこと' do
          expect do
            post admins_toppings_path, params: invalid_topping_params
          end.to change { Topping.count }.by(0)
        end
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post admins_toppings_path, params: topping_params
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "トッピングの編集ページ (GET #edit)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        get edit_admins_topping_path(topping)
        expect(response.status).to eq 200
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get edit_admins_topping_path(topping)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "トッピングの更新 (PUT #update)" do
    let(:update_topping_params) { { topping: { name: "そこをなんとか！"} } }
    let(:invalid_update_topping_params) { { topping: { name: nil } } }

    context '管理者ログインしている場合' do
      before { sign_in admin }

      context '有効な値の場合' do
        before { put admins_topping_path(topping), params: update_topping_params }

        it '正常にリクエストを返すこと' do
          expect(response.status).to eq 302
        end
        it '更新が成功すること' do
          expect(topping.reload.name).to eq 'そこをなんとか！'
        end
        it '登録一覧ページにリダイレクトすること' do
          expect(response).to redirect_to admins_products_path
        end
      end

      context '無効な値の場合' do
        before { put admins_topping_path(topping), params: invalid_update_topping_params }

        it '更新が失敗すること' do
          expect(topping.reload.name).not_to eq nil
        end
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        put admins_topping_path(topping), params: update_topping_params
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "トッピングの削除 (DELETE #destroy)" do
    context 'ログインユーザーの場合' do
      before { sign_in admin }

      it '最新情報が削除されること' do
        expect do
          delete admins_topping_path(topping)
        end.to change { Topping.count }.by(-1)
      end
      it '登録一覧ページにリダイレクトすること' do
        delete admins_topping_path(topping)
        expect(response).to redirect_to admins_products_path
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        delete admins_topping_path(topping)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

end
