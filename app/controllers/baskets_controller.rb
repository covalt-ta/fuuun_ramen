class BasketsController < ApplicationController
  before_action :authenticate_user!


  def show
    basket = current_user.prepare_basket
    @product_toppings = basket.product_toppings
    @total_price = basket.total_price
    set_recommend_product
  end

  private
  def set_recommend_product
    basket_product_ids = current_user.prepare_basket.product_toppings.map {|p|  p.product_id}
    recommend_product_ids = Product.set_ranking - basket_product_ids
    @recommend_product = Product.where(id: recommend_product_ids).first(9)
    if @recommend_product.count <= 3
      @recommend_product = Product.where(display: true).order(created_at: :DESC).first(6)
    end
  end
end
