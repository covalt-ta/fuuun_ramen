class Admins::HolidaysController < Admins::ApplicationController
  def create
    holiday = Holiday.new(holiday_params)
    unless holiday.day.blank?
      holiday.save
      redirect_to admins_shop_path(current_admin.shop), notice: '休日を登録しました'
    else
      redirect_to admins_shop_path(current_admin.shop), alert: '休日登録に失敗しました'
    end
  end

  def destroy
    @holiday = Holiday.find(params[:id])
    if @holiday.destroy
      redirect_to admins_shop_path(current_admin.shop)
    else
      redirect_to admins_shop_path(current_admin.shop)
    end
  end

  private

  def holiday_params
    params.require(:holiday).permit(:day).merge(shop_id: current_admin.shop.id)
  end
end
