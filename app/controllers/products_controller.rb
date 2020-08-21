class ProductsController < ApplicationController
  def index
    @products = Product.includes(:admin).order(created_at: :DESC)
  end

  def show
    @product = Product.find(params[:id])
    @toppings = Topping.all
    @product_topping = ProductTopping.new
  end
end
