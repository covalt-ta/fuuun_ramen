require 'rails_helper'

RSpec.describe "Admins::Reservations", type: :request do
  let(:admin) { create(:admin) }
  let(:reservation) { create(:reservation) }

  describe "予約の一覧表示 (GET #index)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        get admins_reservations_path
        expect(response.status).to eq 200
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get admins_reservations_path
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
  describe "予約の詳細表示 (GET #show)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        get admins_reservation_path(reservation)
        expect(response.status).to eq 200
      end
    end
    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get admins_reservation_path(reservation)
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end
end
