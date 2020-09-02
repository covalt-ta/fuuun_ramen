class ProductToppings::AddToBasketsController < ProductToppings::ApplicationController
  def create
    basket = current_user.prepare_basket
    product = Product.find(params[:product_id]) # Hashidを使用の為、product_idを取得しやすいようにまずproductを取得

    product_topping = ProductTopping.create!(product_id: product.id, topping_ids: product_topping_params)
    basket.basket_products.create!(product_topping_id: product_topping.id)

    redirect_to basket_path
  end

  private

  def product_topping_params
    if params[:product_topping]
      params[:product_topping][:topping_ids]
    else
      []
    end
  end
end
