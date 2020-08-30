class Admins::ProductsController < Admins::ApplicationController
  before_action :set_product, only: %i(edit update destroy)

  def index
    @products = Product.all.order(updated_at: :DESC)
    @toppings = Topping.all.order(updated_at: :DESC)
    @informations = Information.all.order(updated_at: :DESC)


  end

  def new
    @product = current_admin.products.build
    @topping = current_admin.toppings.build
    @information = current_admin.informations.build
  end

  def create
    @product = current_admin.products.build(product_params)
    if @product.save
      flash[:notice] = "商品が追加されました"
      redirect_to root_path
    else
      flash.now[:alert] = "商品追加に失敗しました"
      redirect_to action: :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: "商品を編集しました"
    else
      redirect_to :edit, alert: "商品の編集ができませんでした"
    end
  end

  def destroy
    if @product.destroy
      redirect_to root_path, notice: '商品を削除しました'
    else
      redirect_to :edit, alert: "商品の削除ができませんでした"
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :text, :price, :category_id, :image, :display).merge(admin_id: current_admin.id)
  end

  def set_product
    @product = Product.find_by_hashid(params[:id])
  end
end
