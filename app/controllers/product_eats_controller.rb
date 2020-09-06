class ProductEatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def create
    ProductEat.create(user_id: current_user.id, product_id: @product.id)
    redirect_to product_path(@product)
  end

  def destroy
    product_eat = current_user.product_eats.find_by(product_id: @product.id)
    product_eat.destroy
    redirect_to product_path(@product)
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end
end
