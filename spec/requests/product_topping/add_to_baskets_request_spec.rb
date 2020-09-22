require 'rails_helper'

RSpec.describe "ProductTopping::AddToBaskets", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:toppings) { create_list(:topping, 3) }
  let(:product_topping_params) { { product_topping_params: { topping_ids: toppings.map! {|t| t.id} } } }

  describe "買い物かごへの保存 (POST #create)" do
    context 'ログインユーザーの場合' do
      before { sign_in user }

      context '有効な値の場合' do
        it '正常にリクエストを返すこと' do
          post product_add_to_baskets_path(product), params: product_topping_params
          expect(response.status).to eq 302
        end
        it 'ProductToppingsが保存されること' do
          expect do
            post product_add_to_baskets_path(product), params: product_topping_params
          end.to change { ProductTopping.count }.by(1)
        end
        it '買い物かごに保存されること' do
          expect do
            post product_add_to_baskets_path(product), params: product_topping_params
          end.to change { BasketProduct.count }.by(1)
        end
        it '買い物かごページにリダイレクトされること' do
          post product_add_to_baskets_path(product), params: product_topping_params
          expect(response).to redirect_to basket_path
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        post product_add_to_baskets_path(product), params: product_topping_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
