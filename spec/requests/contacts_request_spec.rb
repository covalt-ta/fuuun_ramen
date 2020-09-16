require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "お問い合わせ内容の保存 (POST #create)" do
    let(:contact_params) { { contact: FactoryBot.attributes_for(:contact) } }
    let(:invalid_contact_params) { { contact: FactoryBot.attributes_for(:contact, name: nil) } }

    context '有効な値の場合' do
      it '正常にリクエストを返すこと' do
        post contact_path, params: contact_params
        expect(response.status).to eq 302
      end
      it 'コメントが保存されること' do
        expect do
          post contact_path, params: contact_params
        end.to change { Contact.count }.by(1)
      end
      it 'トップページにリダイレクトされること' do
        post contact_path, params: contact_params
        expect(response).to redirect_to root_path
      end
    end

    context '無効な値の場合' do
      it 'お問い合わせ内容が保存されないこと' do
        expect do
          post contact_path, params: invalid_contact_params
        end.to change { Contact.count }.by(0)
      end
      it 'トップページにリダイレクトされること' do
        post contact_path, params: invalid_contact_params
        expect(response).to redirect_to root_path
      end
    end
  end
end
