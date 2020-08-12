class ProductsController < ApplicationController
  def index
    @products = Product.includes(:admin).order(created_at: :DESC)
  end
end
