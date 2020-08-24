class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_new_card, only: %i(new_reservation create_reservation new create)


  def new_reservation
    @reservation = Reservation.new
  end

  def create_reservation
    reservation = Reservation.new(reservation_params)
    render :new_reservation and return unless reservation.valid?
    session[:reservation] = reservation.attributes
    redirect_to action: :new
  end

  def new
    session_reservation
    basket = current_user.prepare_basket
    @product_toppings = basket.product_toppings
    @total_price = basket.total_price
  end

  def create
    # 商品の購入金額の計算
    product_topping_ids = params[:product_topping_ids].map(&:to_i)
    reservation = Reservation.new(session["reservation"]) 

    current_user.checkout!(
      product_topping_ids: product_topping_ids,
      day: reservation.day,
      time_zone_id: reservation.time_zone_id,
      count_person_id: reservation.count_person_id
    )
    
    session["reservation"].clear
    redirect_to root_path, notice: '決済に成功しました'
  end

  private
  def reservation_params
    params.require(:reservation).permit(:day, :time_zone_id, :count_person_id)
  end

  def move_to_new_card
    redirect_to new_card_path and return unless current_user.card.present?
  end

  def session_reservation
      @day = session["reservation"]["day"]
      @time_zone = TimeZone.find(session["reservation"]["time_zone_id"]).name
      @count_person = CountPerson.find(session["reservation"]["count_person_id"]).name
  end
end