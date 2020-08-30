class Admins::ToppingsController < Admins::ApplicationController
  before_action :set_topping, only: %i(edit update destroy)

  def new
    @topping = current_admin.toppings.build
  end

  def create
    @topping = current_admin.toppings.build(topping_params)
    if @topping.save
      redirect_to admins_root_path
    else
      redirect_to action: :new
    end
  end

  def edit
    redirect_to admins_products_path unless no_update_topping(@topping)
  end

  def update
    if @topping.update(topping_params)
      redirect_to admins_products_path
    else
      redirect_to action: :edit
    end
  end

  def destroy
    if @topping.destroy
      redirect_to admins_products_path
    else
      redirect_to admins_products_path
    end
  end

  private
  def topping_params
    params.require(:topping).permit(:name, :price, :display).merge(admin_id: current_admin.id)
  end

  def set_topping
    @topping = Topping.find(params[:id])
  end

  # 買い物かごや購入履歴がある商品の編集を制限
  def no_update_topping(topping)
    @toppings = ProductToppingRelation.where(topping_id: topping.id)
    @products.blank?
  end
end
