require 'rails_helper'

RSpec.describe "Admins::Informations", type: :request do
  let(:admin) { create(:admin) }
  let(:shop) { create(:shop, admin_id: admin.id) }
  let(:product_params) { { product: FactoryBot.attributes_for(:product, admin_id: admin.id) } }

  let(:invalid_product_params) { { product: FactoryBot.attributes_for(:product, name: nil, admin_id: admin.id) } }
  let!(:product) { create(:product, admin_id: admin.id)}

  describe "商品情報の一覧 (GET #index)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        get admins_products_path
        expect(response.status).to eq 200
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get admins_products_path
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
  describe "商品の新規作成ページ (GET #new)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        get new_admins_product_path
        expect(response.status).to eq 200
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get new_admins_product_path
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "商品の保存 (POST #create)" do
    context '管理者ログインしている場合' do
      before do
        sign_in admin
      end
      context '有効な値の場合' do
        it '正常にリクエストを返すこと' do
          post admins_products_path, params: product_params
          expect(response.status).to eq 302
        end

        # it '商品情報が保存されること' do
        #   expect do
        #     post admins_products_path, params: product_params
        #   end.to change { Product.count }.by(1)
        # end
        # it 'attaches the uploaded file' do
        #   file = fixture_file_upload(Rails.root.join('spec/fixtures', 'sample_ramen.jpg'), 'image/jpg')
        #   expect {
        #     post admins_products_path, params: { product: { image: file } }
        #   }.to change(ActiveStorage::Attachment, :count).by(1)
        # end

        it '新規登録ページにリダイレクトされること' do
          post admins_products_path, params: product_params
          expect(response).to redirect_to new_admins_product_path
        end
      end

      context '無効な値の場合' do
        it '最新情報が保存されないこと' do
          expect do
            post admins_products_path, params: invalid_product_params
          end.to change { Product.count }.by(0)
        end
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post admins_products_path, params: product_params
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "商品情報の編集画面 (GET #edit)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        get edit_admins_product_path(product)
        expect(response.status).to eq 200
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get edit_admins_product_path(product)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "商品の更新 (PUT #update)" do
    let(:update_product_params) { { product: { name: "世界一のラーメン"} } }
    let(:invalid_update_product_params) { { product: { name: nil } } }

    context '管理者ログインしている場合' do
      before { sign_in admin }

      context '有効な値の場合' do
        before { put admins_product_path(product), params: update_product_params }

        it '正常にリクエストを返すこと' do
          expect(response.status).to eq 302
        end
        it '更新が成功すること' do
          expect(product.reload.name).to eq '世界一のラーメン'
        end
        it '登録一覧ページにリダイレクトすること' do
          expect(response).to redirect_to admins_products_path
        end
      end

      context '無効な値の場合' do
        before { put admins_product_path(product), params: invalid_update_product_params }

        it '更新が失敗すること' do
          expect(product.reload.name).not_to eq nil
        end
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        put admins_product_path(product), params: update_product_params
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "商品の削除 (DELETE #destroy)" do
    context 'ログインユーザーの場合' do
      before do
        sign_in admin
        @product = build(:product)
        @product.save
      end

      it '最新情報が削除されること' do
        expect do
          delete admins_product_path(product)
        end.to change { Product.count }.by(-1)
      end
      it '登録一覧ページにリダイレクトすること' do
        delete admins_product_path(product)
        expect(response).to redirect_to admins_products_path
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        delete admins_product_path(product)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
