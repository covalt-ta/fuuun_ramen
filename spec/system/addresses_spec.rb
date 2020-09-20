require 'rails_helper'

RSpec.describe "Addresses", type: :system do
  describe '住所の登録' do
    let(:user) { create(:user) }
    let(:address) { build(:address, user_id: user.id)}

    it '住所登録が成功する場合' do
      sign_in_user(user)
      visit user_path(user)
      find("input[id='tab02']").click
      click_on '住所を登録する'
      fill_in "address[postal_code]", with: address.postal_code
      find("option[value='#{address.prefecture_id}']").select_option
      fill_in "address[city]", with: address.city
      fill_in "address[block]", with: address.block
      fill_in "address[building]", with: address.building
      fill_in "address[phone_number]", with: address.phone_number

      expect{
        find("input[name='commit']").click
      }.to change { Address.count }.by(1)

      expect(current_path).to eq user_path(user)
    end
    it '住所登録が失敗する場合' do
      sign_in_user(user)
      visit user_path(user)
      find("input[id='tab02']").click
      click_on '住所を登録する'
      fill_in "address[postal_code]", with: ""
      find("option[value='#{address.prefecture_id}']").select_option
      fill_in "address[city]", with: address.city
      fill_in "address[block]", with: address.block
      fill_in "address[building]", with: address.building
      fill_in "address[phone_number]", with: address.phone_number

      expect{
        find("input[name='commit']").click
      }.to change { Address.count }.by(0)

      expect(current_path).to eq new_address_path
    end
  end
end
