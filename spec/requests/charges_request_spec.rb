require 'rails_helper'

RSpec.describe "Charges", type: :request do
  let(:user) { create(:user) }
  let(:product_topping) { create(:product_topping) }
  let(:holiday) { create(:holiday) }

  describe "予約日時入力 (GET #new_reservation)" do
    context 'ログインユーザーの場合' do
      before do
        sign_in user
      end

      context 'クレジットカード登録がある場合' do
        let!(:card) { create(:card, user_id: user.id) }
        it "正常にリクエストを返すこと" do
          get new_reservation_charges_path
          expect(response).to have_http_status(200)
        end
      end

      context 'クレジットカード登録がない場合' do
        it 'カード登録ページにリダイレクトされること' do
          get new_reservation_charges_path
          expect(response).to redirect_to redirect_to new_card_path
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        get new_reservation_charges_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "予約登録処理 (POST #create_reservation)" do
    let(:reservation_params) { { reservation: FactoryBot.attributes_for(:reservation, user_id: user.id) } }
    let(:invalid_reservation_params) { { reservation: FactoryBot.attributes_for(:reservation, day: day, user_id: user.id) } }
    let!(:card) { create(:card, user_id: user.id) }

    context 'ログインユーザーの場合' do
      before do
        sign_in user
      end

      context '有効な値の場合' do
        it 'sessionの値が更新されていること' do
          post create_reservation_charges_path, params: reservation_params
          expect(session[:reservation]).to be_truthy
        end

        it '決済確認ページへリダイレクトすること' do
          post create_reservation_charges_path, params: reservation_params
          expect(response).to redirect_to new_charge_path
        end
      end

      context '無効な値の場合' do
        let(:day) { nil }
        it '予約日時入力画面にリダイレクトされること' do
          post create_reservation_charges_path, params: invalid_reservation_params
          expect(response).to redirect_to new_reservation_charges_path
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post create_reservation_charges_path, params: reservation_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "購入確認画面 (GET #new)" do
    let(:reservation) { {reservation: FactoryBot.attributes_for(:reservation, user_id: user.id) } }
    let!(:card) { create(:card, user_id: user.id) }


    context 'ログインユーザーの場合' do
      before do
        sign_in user
        allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(reservation)
      end

      context '有効な値である場合' do
        it '正常にリクエストを返すこと' do
          # get new_charge_path
          # expect(response.status).to eq 200
        end
      end

      context '無効な値が存在する場合' do
        context 'dayの値が定休日の場合' do
          let(:day) { holiday.day}

          it '予約日時入力画面にリダイレクトされること' do
          end
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get new_charge_path
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "購入処理 (POST #create)" do
    let!(:reservation) { {reservation: FactoryBot.attributes_for(:reservation, user_id: user.id) } }
    let!(:card) { create(:card, user_id: user.id) }
    let!(:product_toppings) { create_list(:product_topping, 3)}
    let!(:product_topping_ids) { { product_topping_ids: product_toppings.map! {|p| p.id} }}
    # let(product_topping) { FactoryBot.create(:ptoduct_topping)}

    context 'ログインユーザーの場合' do
      before do
        sign_in user
      end

      context '有効な値である場合' do
        it '正常にリクエストを返すこと' do
          # post charges_path, params: product_topping_ids
          # expect(response.status).to eq 302
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        post charges_path, params: product_topping_ids
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
