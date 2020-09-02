class Admins::ToppingsController < Admins::ApplicationController
  before_action :set_topping, only: %i(edit update destroy)

  def new
    @topping = current_admin.toppings.build
  end

  def create
    @topping = current_admin.toppings.build(topping_params)
    if @topping.save
      redirect_to new_admins_product_path, notice: "「#{@topping.name}」を追加しました"
    else
      redirect_to new_admins_product_path, alert: "トッピング商品の追加に失敗しました"
    end
  end

  def edit
    redirect_to admins_products_path, alert: "「#{@topping.name}」は編集・削除できません" unless no_update_topping(@topping)
  end

  def update
    if @topping.update(topping_params)
      redirect_to admins_products_path, notice: "「#{@topping.name}」を更新しました"
    else
      redirect_to admins_products_path, alert: "「#{@topping.name}」を更新できませんでした"
    end
  end

  def destroy
    if @topping.destroy
      redirect_to admins_products_path, notice: "「#{@topping.name}」を削除しました"
    else
      redirect_to admins_products_path, alert: "「#{@topping.name}」は削除できませんでした"
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
    toppings = ProductToppingRelation.where(topping_id: topping.id)
    toppings.blank?
  end
end
