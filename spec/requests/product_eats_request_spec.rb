require 'rails_helper'

RSpec.describe "ProductEats", type: :request do
  let(:user) { create(:user) }
  let!(:product) { create(:product) }
  let!(:product_eat) { create(:product_eat)}
  before { sign_in user }

  describe "食べた！を作成するリクエスト (POST #create)" do
    it '正常にリクエストが成功すること' do
      post product_product_eats_path(product), xhr: true
      expect(response.status).to eq 200
    end
    it '食べた！が1つ増える' do
      expect do
        post product_product_eats_path(product), xhr: true
      end.to change { ProductEat.count }.by(1)
    end
  end

  describe '食べた！を取り消すリクエスト（DELETE #destroy）' do
    before { post product_product_eats_path(product), xhr: true }
    it '正常にリクエストが成功すること' do
      delete product_product_eat_path(product, product_eat), xhr: true
      expect(response.status).to eq 200
    end
    it '食べた！が1つ減る' do
      expect do
        delete product_product_eat_path(product, product_eat), xhr: true
      end.to change { ProductEat.count }.by(-1)
    end
  end
end
