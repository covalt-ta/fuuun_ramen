class BasketsController < ApplicationController
  before_action :authenticate_user!

  def show
    basket = current_user.prepare_basket
    @product_toppings = basket.product_toppings
    @total_price = basket.total_price
  end
end
