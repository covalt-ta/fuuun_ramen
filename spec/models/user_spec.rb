# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birthday               :date             not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  first_name             :string(255)      not null
#  first_name_kana        :string(255)      not null
#  last_name              :string(255)      not null
#  last_name_kana         :string(255)      not null
#  nickname               :string(255)      not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user)}

  describe 'バリデーションのテスト' do
    context 'ユーザー作成ができる場合' do
      it '全ての項目が正しく存在すれば登録できる' do
        expect(user).to be_valid
      end
      it 'passwordが6文字以上で登録できる' do
        user.password = '12test'
        user.password_confirmation = user.password
        expect(user).to be_valid
      end
    end
    context 'ユーザー作成ができない場合' do
      it 'nicknameが空では登録できない' do
        user.nickname = nil
        user.valid?
        expect(user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        user.email = nil
        user.valid?
        expect(user.errors.full_messages).to include('Eメールを入力してください')
      end
      it 'emailに＠が含まれていないと登録できない' do
        user.email = 'test'
        user.valid?
        expect(user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'emailが他のユーザーと重複していると登録できない' do
        user_second = FactoryBot.create(:user)
        user.email = user_second.email
        user.valid?
        expect(user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが6文字より少ないと登録できない' do
        user.password = '123aa'
        user.password_confirmation = user.password
        user.valid?
        expect(user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        user.password_confirmation = '12test'
        user.valid?
        expect(user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'last_nameが空だと登録できない' do
        user.last_name = nil
        user.valid?
        expect(user.errors.full_messages).to include('苗字を入力してください')
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）でければ登録できない' do
        user.last_name = 'Caesar'
        user.valid?
        expect(user.errors.full_messages).to include('苗字は不正な値です')
      end
      it 'first_nameが空だと登録できない' do
        user.first_name = nil
        user.valid?
        expect(user.errors.full_messages).to include('名前を入力してください')
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）でければ登録できない' do
        user.first_name = 'Gaius'
        user.valid?
        expect(user.errors.full_messages).to include('名前は不正な値です')
      end
      it 'last_name_kanaが空だと登録できない' do
        user.last_name_kana = nil
        user.valid?
        expect(user.errors.full_messages).to include('苗字（カナ）を入力してください')
      end
      it 'last_name_kanaが漢字では登録できない' do
        user.last_name_kana = '新垣'
        user.valid?
        expect(user.errors.full_messages).to include('苗字（カナ）は不正な値です')
      end
      it 'last_name_kanaがひらがなでは登録できない' do
        user.last_name_kana = 'ゆい'
        user.valid?
        expect(user.errors.full_messages).to include('苗字（カナ）は不正な値です')
      end
      it 'first_name_kanaが空だと登録できない' do
        user.first_name_kana = nil
        user.valid?
        expect(user.errors.full_messages).to include('名前（カナ）を入力してください')
      end
      it 'first_name_kanaが漢字では登録できない' do
        user.first_name_kana = '深田'
        user.valid?
        expect(user.errors.full_messages).to include('名前（カナ）は不正な値です')
      end
      it 'first_name_kanaがひらがなでは登録できない' do
        user.first_name_kana = 'きょうこ'
        user.valid?
        expect(user.errors.full_messages).to include('名前（カナ）は不正な値です')
      end
      it 'birthdayが空だと登録できない' do
        user.birthday = nil
        user.valid?
        expect(user.errors.full_messages).to include('誕生日を入力してください')
      end
    end
  end
  # describe 'アソシエーションのテスト' do
  #   user.save
  #   context 'Basketとの関係' do
  #     it '1:1となっている' do

  #     end
  #   end
  # end
end
