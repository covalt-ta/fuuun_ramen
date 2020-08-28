class ProductsController < ApplicationController
  def index
    @products = Product.all.order(created_at: :DESC)
    # @products = @products.page(params[:page])
    @ramen_rices = Product.where(category_id: [2,3]).order(created_at: :DESC)
    # @ramen_rices = @ramen_rices.page(params[:page])
    @others = Product.where(category_id: [4,5,6]).order(created_at: :DESC)
    # @others = @others.page(params[:page])
    @orders = Product.where(category_id: 7).order(created_at: :DESC)
    # @orders = @orders.page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
    @product_topping = ProductTopping.new
  end
end
