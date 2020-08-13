class ProductsController < ApplicationController
  def index
    @products = Product.includes(:admin).order(created_at: :DESC)
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(product_params)
    if product.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :text, :price, :category_id).merge(admin_id: current_admin.id)
  end
end
