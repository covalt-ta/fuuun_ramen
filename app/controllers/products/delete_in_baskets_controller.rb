class Products::DeleteInBasketsController < Products::ApplicationController
  def create
    basket = current_user.prepare_basket
    product = Product.find(params[:product_id])

    basket_product = basket.basket_products.find_by(product_id: product.id)
    basket_product.destroy!

    redirect_to basket_path
  end
end