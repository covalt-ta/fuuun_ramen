class ProductsController < ApplicationController
  def index
    @products = Product.all.order(created_at: :DESC)
    @ramens = Product.where(category_id: 2)
    @rices = Product.where(category_id: 3)
    @others = Product.where(category_id: [4,5,6])
    @orders = Product.where(category_id: 7)


  end

  def show
    @product = Product.find(params[:id])
    @product_topping = ProductTopping.new
  end
end
