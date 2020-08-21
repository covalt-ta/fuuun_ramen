class Products::AddToBasketsController < Products::ApplicationController
  def create
    binding.pry
    basket = current_user.prepare_basket
    product = Product.find(params[:product_id]) # Hashidを使用の為、product_idを取得しやすいようにまずproductを取得
    
    product_toppings = ProductTopings.new(product_id: product.id, topping_id: topping_ids)
    basket.basket_products.create!(product_topping_id: product_topping_ids)

    redirect_to basket_path
  end
end