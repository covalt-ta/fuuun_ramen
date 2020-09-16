require 'rails_helper'

RSpec.describe "Comments", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:comment_params) { { comment: FactoryBot.attributes_for(:comment, user_id: user.id, product_id: product.id) } }
  let(:invalid_comment_params) { { comment: FactoryBot.attributes_for(:comment, comment: nil, user_id: user.id, product_id: product.id) } }

  describe "投稿内容の保存 (POST #create)" do
    context 'ログインユーザーの場合' do
      before { sign_in user }

      context '有効な値の場合' do
        it '正常にリクエストを返すこと' do
          post product_comments_path(product), params: comment_params
          expect(response.status).to eq 302
        end
        it 'コメントが保存されること' do
          expect do
            post product_comments_path(product), params: comment_params
          end.to change { Comment.count }.by(1)
        end
        it '商品詳細ページにリダイレクトされること' do
          post product_comments_path(product), params: comment_params
          expect(response).to redirect_to product_path(product)
        end
      end

      context '無効な値の場合' do
        it '商品詳細ページにリダイレクトされること' do
          post product_comments_path(product), params: invalid_comment_params
          expect(response).to redirect_to product_path(product)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        post product_comments_path(product), params: comment_params
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "投稿内容の削除 (DELETE #destroy)" do
    let!(:comment) { create(:comment, user_id: user.id, product_id: product.id)}

    context 'ログインユーザーの場合' do
      before { sign_in user }

      context '有効な値の場合' do
        it '正常にリクエストを返すこと' do
          delete product_comment_path(product, comment)
          expect(response.status).to eq 302
        end
        it 'コメントが削除されること' do
          expect do
            delete product_comment_path(product, comment)
          end.to change { Comment.count }.by(-1)
        end
        it '商品詳細ページにリダイレクトされること' do
          delete product_comment_path(product, comment)
          expect(response).to redirect_to product_path(product)
        end
      end
    end
    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされること' do
        delete product_comment_path(product, comment)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
