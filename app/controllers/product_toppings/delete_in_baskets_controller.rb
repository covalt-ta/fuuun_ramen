class ProductToppings::DeleteInBasketsController < ProductToppings::ApplicationController
  def create
    basket = current_user.prepare_basket
    # product = Product.find(params[:product_id])

    basket_product_topping = basket.product_toppings.find_by(id: params[:product_topping_id])
    basket_product_topping.destroy!

    redirect_to basket_path
  end
end
