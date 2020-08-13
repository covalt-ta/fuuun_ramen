class Admins::ProductsController < Admins::ApplicationController
  def new
    @product = current_admin.products.build
  end

  def create
    @product = current_admin.products.build(product_params)
    if @product.save
      flash[:notice] = "商品が追加されました"
      redirect_to root_path
    else
      flash.now[:alert] = "商品追加に失敗しました"
      render :new
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :text, :price, :category_id, :image).merge(admin_id: current_admin.id)
  end
end