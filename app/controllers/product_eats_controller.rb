class ProductEatsController < ApplicationController
  before_action :set_product

  def create
    @product_eat = current_user.product_eats.build(product_id: @product.id)
    @product_eat.save
  end

  def destroy
    @product_eat = current_user.product_eats.find_by(product_id: @product.id)
    @product_eat.destroy
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end
end
