require 'rails_helper'

RSpec.describe "Admins::Shops", type: :request do
  let(:admin) { create(:admin) }
  let(:shop_params) { { shop: FactoryBot.attributes_for(:shop, admin_id: admin.id) } }
  let(:invalid_shop_params) { { shop: FactoryBot.attributes_for(:shop, name: nil, admin_id: admin.id) } }


  describe "店舗作成ページ (GET #new)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      context 'shop情報を初めて登録する場合' do
        it '正常にリクエストを返すこと' do
          get new_admins_shop_path
          expect(response.status).to eq 200
        end
      end

      context 'shop情報がすでに存在する場合' do
        let!(:registered_shop) {create(:shop, admin_id: admin.id)}
        it 'shop情報が存在する場合にリダイレクトされること' do
          get new_admins_shop_path
          expect(response).to redirect_to admins_shops_path(registered_shop)
        end
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get new_admins_shop_path
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "店舗情報の保存 (POST #create)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }
      context '有効な値の場合' do
        it '正常にリクエストを返すこと' do
          post admins_shops_path, params: shop_params
          expect(response.status).to eq 302
        end
        it '店舗情報が保存されること' do
          expect do
            post admins_shops_path, params: shop_params
          end.to change { Shop.count }.by(1)
        end
        it '店舗詳細ページにリダイレクトされること' do
          post admins_shops_path, params: shop_params
          expect(response).to redirect_to  "/admins/shops/#{Shop.first.id}"
        end
      end

      context '無効な値の場合' do
        it '最新情報が保存されないこと' do
          expect do
            post admins_shops_path, params: invalid_shop_params
          end.to change { Shop.count }.by(0)
        end
        it '店舗作成ページにリダイレクトされること' do
          post admins_shops_path, params: invalid_shop_params
          expect(response).to redirect_to new_admins_shop_path
        end
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post admins_shops_path, params: shop_params
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "店舗詳細画面 (GET #show)" do
    let(:shop) { create(:shop, admin_id: admin.id) }
    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        get admins_shop_path(shop)
        expect(response.status).to eq 200
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get admins_shop_path(shop)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "店舗情報の更新 (PUT #update)" do
    let!(:shop) { create(:shop, admin_id: admin.id) }
    let(:update_shop_params) { { shop: { name: "そこをなんとかよろしくお願いします！"} } }
    let(:invalid_update_shop_params) { { shop: { name: nil } } }

    context '管理者ログインしている場合' do
      before { sign_in admin }

      context '有効な値の場合' do
        before { put admins_shop_path(shop), params: update_shop_params }

        it '正常にリクエストを返すこと' do
          expect(response.status).to eq 302
        end
        it '更新が成功すること' do
          expect(shop.reload.name).to eq 'そこをなんとかよろしくお願いします！'
        end
        it '登録一覧ページにリダイレクトすること' do
          expect(response).to redirect_to admins_shop_path(shop)
        end
      end

      context '無効な値の場合' do
        before { put admins_shop_path(shop), params: invalid_update_shop_params }

        it '更新が失敗すること' do
          expect(shop.reload.name).not_to eq nil
        end
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        put admins_shop_path(shop), params: update_shop_params
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
