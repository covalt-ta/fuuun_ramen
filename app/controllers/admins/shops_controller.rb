class Admins::ShopsController < Admins::ApplicationController
  before_action :set_shop, only: %i(show update)

  def new
    redirect_to admins_shops_path(current_admin.shop) if Shop.exists?
    @shop = Shop.new
  end

  def create
    if @shop = Shop.create(shop_params)
      redirect_to admins_shop_path(@shop), notice: '店舗情報を登録しました'
    else
      redirect_to new_admins_shop_path, alert: '店舗情報を登録できませんでした'
    end
  end

  def show
    @holiday = Holiday.new
    @holidays = Holiday.all
  end

  def update
    if @shop.update(shop_params)
      redirect_to admins_shop_path(@shop), notice: '店舗情報を更新しました'
    else
      redirect_to admins_shop_path(@shop), alert: '店舗情報を更新できませんでした'
    end
  end

  private
  def shop_params
    params.require(:shop).permit(:name, :email, :open_time_zone_id, :close_time_zone_id,
      :holiday, :postal_code, :prefecture_id, :city, :block, :building, :phone_number).merge(admin_id: current_admin.id)
  end

  def set_shop
    redirect_to admins_shop_path(current_admin.shop) unless Shop.exists?
    @shop = Shop.find(params[:id])
  end
end
