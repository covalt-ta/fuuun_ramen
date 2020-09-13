# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_product_id  (product_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.create(:comment) }
  describe 'バリデーションのテスト' do
    context '保存ができる' do
      it '正しい情報が入力されている' do
        expect(comment).to be_valid
      end
    end
    context '保存ができない' do
      it 'commentが空の場合' do
        comment.comment = nil
        comment.valid?
        expect(comment.errors[:comment]).to include("を入力してください")
      end
      it 'commentが141文字以上' do
        comment.comment = "あ" * 141
        comment.valid?
        expect(comment.errors[:comment]).to include("は140文字以内で入力してください")
      end
      it 'Userが空の場合' do
        comment.user = nil
        comment.valid?
        expect(comment.errors[:user]).to include("を入力してください")
      end
      it 'Productが空の場合' do
        comment.product = nil
        comment.valid?
        expect(comment.errors[:product]).to include("を入力してください")
      end
    end
  end
end
