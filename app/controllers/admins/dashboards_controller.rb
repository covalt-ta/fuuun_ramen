class Admins::DashboardsController < Admins::ApplicationController
  before_action :search_reservation

  def index
    # 当月の予約を取得
    month_reservations = Reservation.includes(:product_toppings).where(day: Time.current.all_month)
    # 来客数合計を算出する
    @count_person = ReservationsData.count_person(month_reservations)
    # 今月のTake Out数を算出する
    @count_takeout = month_reservations.where(count_person_id: 1).count

    # 予約済product_toppingsと当月売上合計を算出する
    @this_month_product_toppings = ReservationsData.product_toppings(month_reservations)
    @total_price = PriceCalculator.total(@this_month_product_toppings)

    # 検索結果
    @results_count_person = ReservationsData.count_person(@p.result)
    # 今月のTake Out数を算出する, dateを渡す必要がある
    @results_count_takeout = @p.result.where(count_person_id: 1).count

    # 予約済product_toppingsと当月売上合計を算出する
    @results_product_toppings = ReservationsData.product_toppings(@p.result)
    @results_total_price = PriceCalculator.total(@results_product_toppings)
  end

  def search
    @results = @p.result.order(day: :ASC)
    # 検索ヒットした予約に紐づくproduct_toppingsを取得
    @product_toppings = ReservationsData.product_toppings(@results)
  end

  def ranking
    # 商品のランキングデータの算出
    @product_count = Reservation.ransack(params[:q]).result.joins(:product_toppings).group(:product_id).count
    product_ids = Hash[@product_count.sort_by{ |_, v| -v}].keys # 配列でproduct_id [id,id,id]
    @product_ranking = Product.where(id: product_ids) # ランキング順にproductを取得

    # トッピングのランキングデータの算出
    @results_product_toppings = ReservationsData.product_toppings(@p.result)
    topping_count_ary = @results_product_toppings.map {|p| p.toppings.map {|t| t.id}}
    @topping_count = topping_count_ary.flatten.group_by(&:itself).map{|key, value| [key, value.count]}.to_h
    topping_ids = Hash[@topping_count.sort_by{ |_, v| -v}].keys
    # 「.order・・・」はランキング順のtopping_idsを渡してもランキング順の取得ができてなかった為の記述
    @topping_ranking = Topping.where(id: topping_ids).order("field(id, #{topping_ids.join(',')})")
  end

  private
  def search_reservation
    @p = Reservation.includes(:product_toppings).ransack(params[:q])
  end
end
