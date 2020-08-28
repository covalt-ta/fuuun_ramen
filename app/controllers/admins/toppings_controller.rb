class Admins::ToppingsController < Admins::ApplicationController

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
  end

  def destroy
  end

  private
  def topping_params
    params.require(:topping).permit(:name, :price).merge(admin_id: current_admin.id)
  end
end
