# == Schema Information
#
# Table name: contacts
#
#  id           :bigint           not null, primary key
#  email        :string(255)      not null
#  name         :string(255)      not null
#  phone_number :string(255)
#  text         :text(65535)      not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { FactoryBot.create(:contact)}
  describe 'バリデーションのテスト' do
    context '保存ができる場合' do
      it '正しく情報が存在している' do
        expect(contact).to be_valid
      end
      it 'phone_numberが空でも保存できる' do
        contact.phone_number = nil
        expect(contact).to be_valid
      end
    end
    context '保存ができない場合' do
      it 'emailが空の場合、保存できない' do
        contact.email = nil
        contact.valid?
        expect(contact.errors[:email]).to include("を入力してください")
      end
      it 'emailに@マークが含まれていない場合、保存できない' do
        contact.email = "test123456"
        contact.valid?
        expect(contact.errors[:email]).to include("は不正な値です")
      end
      it 'nameが存在しない場合、保存できない' do
        contact.name = nil
        contact.valid?
        expect(contact.errors[:name]).to include("を入力してください")
      end
      it 'nameが41文字以上の場合、保存できない' do
        contact.name = "あ" * 41
        contact.valid?
        expect(contact.errors[:name]).to include("は40文字以内で入力してください")
      end
      it 'textが空の場合、保存できない' do
        contact.text = nil
        contact.valid?
        expect(contact.errors[:text]).to include("を入力してください")
      end
      it 'textが1001文字以上の場合、保存できない' do
        contact.text = "あ" * 1001
        contact.valid?
        expect(contact.errors[:text]).to include("は1000文字以内で入力してください")
      end
    end
  end
end
