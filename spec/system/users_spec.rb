require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'ユーザー新規登録' do
    let(:user) { build(:user) }

    context 'ユーザー新規登録ができるとき' do
      it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
        visit root_path
        expect(page).to have_content("新規登録")

        visit new_user_registration_path

        fill_in "user[nickname]", with: user.nickname
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        fill_in "user[password_confirmation]", with: user.password_confirmation
        fill_in "user[last_name]", with: user.last_name
        fill_in "user[first_name]", with: user.first_name
        fill_in "user[last_name_kana]", with: user.last_name_kana
        fill_in "user[first_name_kana]", with: user.first_name_kana
        select "1983", from: "user_birthday_1i"
        select "12", from: "user_birthday_2i"
        select "6", from: "user_birthday_3i"

        # サインアップボタンを押すとユーザーモデルのカウントが1上がる
        expect {
          find("input[name='commit']").click
        }.to change { User.count }.by(1)

        # トップページへ遷移しているか確認する
        expect(current_path).to eq products_path

        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていない
        expect(page).to have_no_content("新規登録")
        expect(page).to have_no_content("ログイン")
      end
    end

    context 'ユーザー新規登録ができないとき' do
      it '誤った情報ではをユーザー新規登録ができずに、新規登録ページへ戻ってくる' do
        # 新規登録ページへ移動する
        visit new_user_registration_path

        # ユーザー情報を入力する
        fill_in "user[nickname]", with: ""
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        fill_in "user[password_confirmation]", with: user.password_confirmation
        fill_in "user[last_name]", with: user.last_name
        fill_in "user[first_name]", with: user.first_name
        fill_in "user[last_name_kana]", with: user.last_name_kana
        fill_in "user[first_name_kana]", with: user.first_name_kana
        select "1983", from: "user_birthday_1i"
        select "12", from: "user_birthday_2i"
        select "6", from: "user_birthday_3i"

        # サインアップボタンを押してもユーザーモデルのカウントは上がらない
        expect{
          find("input[name='commit']").click
        }.to change { User.count }.by(0)
        # 新規登録ページへ戻される
        expect(current_path).to eq "/users"
      end
    end
  end

  describe "ログイン" do
    let(:user) { create(:user) }
    context 'ログインできる場合' do
      it '保存されているユーザーの情報と合致すればログインできる' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがある
        expect(page).to have_content("ログイン")
        # ログインページへ遷移する
        visit new_user_session_path
        # 正しいユーザー情報を入力する
        fill_in "user[email]", with: user.email
        fill_in "user[password]", with: user.password
        # ログインボタンを押す
        find("input[name='commit']").click
        # トップページへ遷移する
        expect(current_path).to eq products_path
        # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていない
        # expect(page).to have_no_content("ログイン") セッション「ログインしました」が検知される
        expect(page).to have_no_content("新規登録")
      end
      it 'ログインできない場合' do
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがある
        expect(page).to have_content("ログイン")
        # ログインページへ遷移する
        visit new_user_session_path
        # ユーザー情報を入力する
        fill_in "user[email]", with: "aaaa"
        fill_in "user[password]", with: user.password
        # ログインボタンを押す
        find("input[name='commit']").click
        # ログインページへ戻される
        expect(current_path).to eq new_user_session_path
      end
    end
  end
end

