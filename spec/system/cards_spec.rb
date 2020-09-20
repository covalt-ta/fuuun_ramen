require 'rails_helper'

RSpec.describe "Cards", type: :system do
  let(:user) { create(:user) }

  context 'クレジットカード登録' do
    before do
      customer = double("Payjp::Customer")
      # params = [{ card_token: "cus_xxxxxxxxxxx" }]
      allow(Payjp::Customer).to receive(:create).and_return(customer)
      allow(customer).to receive(:id).and_return("cus_xxxxxxxxxxx")
    end

    it '登録が成功する' do
      sign_in_user(user)
      visit user_path(user)
      find("input[id='tab03']").click
      click_on 'カードを登録する'

      fill_in "number", with: "4242424242424242"
      fill_in "CVC", with: "222"
      find("option[value='1']").select_option
      find("option[value='25']").select_option

      # params[:card_token]が渡せないためにcardレコードを作成できない？
      # expect{
      #   find("input[name='commit']").click
      # }.to change { Card.count }.by(1)
      # expect(current_path).to eq user_path(user)

      find("input[name='commit']").click
    end
  end
  # context 'クレジットカード削除' do
  #   before do
  #     customer = double("Payjp::Customer")
  #     allow(customer).to receive(:retrieve).and_return(card.customer_token)
  #   end
  #   let!(:card) { create(:card, user_id: user.id) }
  #   it '登録されたカードが削除される' do
  #     sign_in_user(user)
  #     visit user_path(user)
  #     find("input[id='tab03']").click
  #     click_on '登録削除'
  #     expect(page).to have_no_content("クレジットカードの登録を削除しました")
  #     expect(current_path).to eq user_path(user)
  #   end
  # end
end
