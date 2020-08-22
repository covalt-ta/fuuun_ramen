class Products::AddToBasketsController < Products::ApplicationController
  def create
    basket = current_user.prepare_basket
    product = Product.find(params[:product_id]) # Hashidを使用の為、product_idを取得しやすいようにまずproductを取得
    
    product_topping = ProductTopping.create!(product_id: product.id, topping_ids: params[:product_topping][:topping_ids])
    basket.basket_products.create!(product_topping_id: product_topping.id)

    redirect_to root_path
    # redirect_to basket_path
  end

end