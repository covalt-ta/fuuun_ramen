require 'rails_helper'

RSpec.describe "Admins::Holidays", type: :request do
  let(:admin) { create(:admin) }
  let(:shop) { create(:shop, admin_id: admin.id) }
  let(:holiday_params) { { holiday: FactoryBot.attributes_for(:holiday, shop_id: shop.id) } }
  let(:invalid_holiday) { { holiday: FactoryBot.attributes_for(:holiday, day: nil, shop_id: shop.id) } }

  describe "休日の保存 (POST #create)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      context '有効な値の場合' do
        it '正常にリクエストを返すこと' do
          post admins_holidays_path, params: holiday_params
          expect(response.status).to eq 302
        end
        it '休日が保存される' do
          expect do
            post admins_holidays_path, params: holiday_params
          end.to change { Holiday.count }.by(1)
        end
        it '店舗情報ページにリダイレクトされる' do
          post admins_holidays_path, params: holiday_params
          expect(response).to redirect_to admins_shop_path(shop)
        end
      end
      context '無効な値の場合' do
        before { post admins_holidays_path, params: holiday_params }

        it 'dayが空の場合は保存されない' do
          expect do
            post admins_holidays_path, params: invalid_holiday
          end.to change { Holiday.count }.by(0)
        end
        it '重複した値の場合は保存されない' do
          expect do
            post admins_holidays_path, params: holiday_params
          end.to change { Holiday.count }.by(0)
        end
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post admins_holidays_path, params: holiday_params
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  describe "休日の削除 (DELETE #destroy)" do
    let!(:holiday) { create(:holiday, shop_id: shop.id) }

    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        delete admins_holiday_path(holiday)
        expect(response.status).to eq 302
      end
      it '休日が削除されること' do
        expect do
          delete admins_holiday_path(holiday)
        end.to change { Holiday.count }.by(-1)
      end
      it '店舗情報ページにリダイレクトされること' do
        delete admins_holiday_path(holiday)
        expect(response).to redirect_to admins_shop_path(shop)
      end
    end
    context '管理者ログインしていない場合' do
      it '管理者ログインページにリダイレクトされること' do
        delete admins_holiday_path(holiday)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
