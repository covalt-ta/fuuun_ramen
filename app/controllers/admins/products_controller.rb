class Admins::ProductsController < Admins::ApplicationController
  before_action :set_product, only: %i[edit update destroy]

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
      redirect_to new_admins_product_path, notice: "「#{@product.name}」を追加しました"
    else
      redirect_to new_admins_product_path, alert: '商品の追加に失敗しました'
    end
  end

  def edit
    redirect_to admins_products_path, alert: "「#{@product.name}」は編集・削除ができません" unless no_update_product(@product)
  end

  def update
    if @product.update(product_params)
      redirect_to admins_products_path, notice: "「#{@product.name}」を編集しました"
    else
      redirect_to admins_products_path, alert: "「#{@product.name}」の編集ができませんでした"
    end
  end

  def destroy
    if @product.destroy
      redirect_to admins_products_path, notice: "「#{@product.name}」を削除しました"
    else
      redirect_to admins_products_path, alert: "「#{@product.name}」の削除ができませんでした"
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :text, :price, :category_id, :image, :display).merge(admin_id: current_admin.id)
  end

  def set_product
    @product = Product.find_by_hashid(params[:id])
  end

  # 買い物かごや購入履歴がある商品の編集を制限
  def no_update_product(product)
    @products = ProductTopping.where(product_id: product.id)
    @products.blank?
  end
end
