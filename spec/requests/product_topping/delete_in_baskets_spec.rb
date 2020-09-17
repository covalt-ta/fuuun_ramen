require 'rails_helper'

RSpec.describe "ProductTopping::DeleteInBaskets", type: :request do
  let(:user) { create(:user) }
  let(:basket) { create(:basket, user_id: user.id) }
  let(:product_topping) { create(:product_topping) }
  let!(:basket_product) { create(:basket_product, basket_id: basket.id, product_topping_id: product_topping.id) }

  describe "買い物かごから削除 (POST #create)" do
    context 'ログインユーザーの場合' do
      before { sign_in user }

      context '有効な値の場合' do
        it '正常にリクエストを返すこと' do
          post product_topping_delete_in_baskets_path(product_topping), params: { product_topping_id: product_topping.id}
          expect(response.status).to eq 302
        end
        it '買い物かごから削除されること' do
          expect do
            post product_topping_delete_in_baskets_path(product_topping), params:  { product_topping_id: product_topping.id}
          end.to change { basket.product_toppings.count }.by(-1)
        end
        it '買い物かごページにリダイレクトされること' do
          post product_topping_delete_in_baskets_path(product_topping), params:  { product_topping_id: product_topping.id}
          expect(response).to redirect_to basket_path
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        post product_topping_delete_in_baskets_path(product_topping), params: { product_topping_id: product_topping.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
