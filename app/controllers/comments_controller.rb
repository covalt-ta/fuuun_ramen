class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def create
    comment = Comment.new(comment_params)
    if comment.save
      redirect_to product_path(@product), notice: "コメントを投稿しました"
    else
      redirect_to product_path(@product), alert: "コメントを投稿できませんでした"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.destroy
      redirect_to product_path(@product), notice: "コメントを削除しました"
    else
      redirect_to product_path(@product), alert: "コメントを削除できませんでした"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment).merge(product_id: @product.id, user_id: current_user.id)
  end

  def set_product
    @product = Product.find_by_hashid(params[:product_id]) || @product = Product.find(params[:product_id])
  end
end
