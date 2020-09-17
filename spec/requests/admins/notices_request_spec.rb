require 'rails_helper'

RSpec.describe "Admins::Notices", type: :request do
  let(:admin) { create(:admin) }
  let(:reservation) { create(:reservation) }
  let!(:notice) { create(:notice, reservation_id: reservation.id, admin_id: admin.id) }

  describe "通知の一覧 (GET #index)" do
    context '管理者ログインしている場合' do
      before { sign_in admin }

      it '正常にリクエストを返すこと' do
        get admins_notices_path
        expect(response.status).to eq 200
      end
      it 'リクエストするとcheckedがtureに更新される' do
        get admins_notices_path
        expect(notice.reload.checked).to eq true
      end
    end

    context '管理者ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get admins_notices_path
        expect(response).to redirect_to new_admin_session_path
      end
    end
  end

  # describe "通知の削除 (#notice_count_delete)" do
  #   let(:reservations) { create_list(:reservation, 31)}
  #   before do
  #     sign_in admin
  #     reservations.each { |reservation| create(:notice, reservation_id: reservation.id, admin_id: admin.id) }
  #     get admins_notices_path
  #   end

  #   it '確認済の通知が30件以上あると、30件になるまで削除される' do
  #     expect do
  #       get admins_notices_path
  #     end.to change { Notice.count }.by(-1)
  #   end
  # end
end
