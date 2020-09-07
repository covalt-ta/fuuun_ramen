class ProductsController < ApplicationController
  def index
    @products = Product.where(display: true).order(updated_at: :DESC)
    # @products = @products.page(params[:page])
    @ramen_rices = Product.where(display: true).where(category_id: [2, 3]).order(updated_at: :DESC)
    # @ramen_rices = @ramen_rices.page(params[:page])
    @others = Product.where(display: true).where(category_id: [4, 5, 6]).order(updated_at: :DESC)
    # @others = @others.page(params[:page])
    @orders = Product.where(display: true).where(category_id: 7).order(updated_at: :DESC)
    # @orders = @orders.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @product_topping = ProductTopping.new
    @topping = Topping.where(display: true)
    @comment = Comment.new
    @comments = @product.comments.order(created_at: :DESC)
    redirect_to root_path if @product.display == false
  end
end
