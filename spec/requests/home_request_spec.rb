require 'rails_helper'

RSpec.describe "Home", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  describe "トップページ #index" do
    context "ログインしていない場合" do
      it "正常にレスポンスを返すこと" do
        get root_path
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end

    context "ユーザーログインしている場合" do
      before { sign_in user }
      it "正常にレスポンスを返すこと" do
        get root_path
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end

    context "管理者ログインしている場合" do
      before { sign_in admin }
      it "正常にレスポンスを返すこと" do
        get root_path
        expect(response).to be_successful
        expect(response.status).to eq 200
      end
    end
  end
end
