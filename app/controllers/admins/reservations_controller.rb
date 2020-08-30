class Admins::ReservationsController < Admins::ApplicationController
  def index
    @today = Date.today
    to_month = @today + 1.month
    @reservations = Reservation.includes(:user, order_record_products: :product_topping).where(day: @today..to_month).order(day: :ASC, time_zone_id: :ASC)
  end

  def show
    @reservation = Reservation.find(params[:id])
  end
end
