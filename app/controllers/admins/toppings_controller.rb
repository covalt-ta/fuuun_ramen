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
  end

  def update
    if @topping.update(information_params)
      redirect_to admins_products_path
    else
      redirect_to action: :edit
    end
  end

  def destroy
    if @topping.destroy
      redirect_to admins_products_path
    else
      redirect_to action: edit
    end
  end

  private
  def topping_params
    params.require(:topping).permit(:name, :price).merge(admin_id: current_admin.id)
  end

  def set_topping
    @topping = Topping.find(params[:id])
  end
end
