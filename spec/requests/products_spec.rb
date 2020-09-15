require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:product) { FactoryBot.create(:product, display: display) }

  describe "商品一覧ページ(GET #index)" do
    let(:display) { true }

    it "正常にリクエストを返すこと" do
      get products_path
      expect(response.status).to eq 200
    end
  end

  describe "商品詳細ページ(GET #show)" do
    context 'displayがtrueの場合' do
      let(:display) { true }

      before do
        get product_path(product)
      end

      it "正常にリクエストを返すこと" do
        expect(response.status).to eq 200
      end
      it "Product情報が存在する" do
        expect(response.body).to include(product.name)
        expect(response.body).to include(product.text)
        expect(response.body).to include(product.price.to_s(:delimited))
      end
      it "買い物かご保存ボタンが存在する" do
        expect(response.body).to include("買い物かごに入れる")
      end
    end

    context 'displayがfalseの場合' do
      let(:display) { false }
      it 'リダイレクトされること' do
        get product_path(product)
        expect(response.status).to eq 302
      end
    end
  end
end
