class Admins::DashboardsController < Admins::ApplicationController
  before_action :search_reservation

  def index
    # 当月の予約を取得
    month_reservations = Reservation.joins(:product_toppings).where(day: Time.current.all_month)
    # 来客数合計を算出する
    @count_person = ReservationsData.count_person(month_reservations)
    # 今月のTake Out数を算出する
    @count_takeout = ReservationsData.count_takeout(Time.current.all_month)
    # 予約済product_toppingsと当月売上合計を算出する
    @product_toppings = ReservationsData.product_toppings(month_reservations)
    @total_price = PriceCalculator.total(@product_toppings)

    # 商品のランキングデータの算出
    @product_count = Reservation.joins(:product_toppings).group(:product_id).count
    product_ids = Hash[@product_count.sort_by{ |_, v| -v}].keys
    @product_ranking = Product.where(id: product_ids)

    # トッピングのランキングデータの算出
    topping_count_ary = @product_toppings.map {|p| p.toppings.map {|t| t.id}}
    @topping_count = topping_count_ary.flatten.group_by(&:itself).map{|key, value| [key, value.count]}.to_h
    topping_ids = Hash[@topping_count.sort_by{ |_, v| -v}].keys
    # 「.order・・・」はランキング順のtopping_idsを渡してもランキング順の取得ができてなかった為の記述
    @topping_ranking = Topping.where(id: topping_ids).order("field(id, #{topping_ids.join(',')})")
  end

  def search
    @results = @p.result.order(day: :ASC)
    # 検索ヒットした予約に紐づくproduct_toppingsを取得
    @product_toppings = ReservationsData.product_toppings(@results)
  end

  private

  def search_reservation
    @p = Reservation.includes(:product_toppings).ransack(params[:q])
  end
end
