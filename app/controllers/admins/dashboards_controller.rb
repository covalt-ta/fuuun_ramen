class Admins::DashboardsController < Admins::ApplicationController
  before_action :search_reservation
  require "csv"

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

    # 本日の予約を取得
    @today = Date.current
    @reservations = Reservation.includes(:user, order_record_products: :product_topping).where(day: @today).order(day: :ASC, time_zone_id: :ASC)

    # CSV出力
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_sales_csv(params[:target_period_start], params[:target_period_end], @p.result, params[:target_period])
      end
    end
  end

  def search
    @p = Reservation.includes(:product_toppings, :user).ransack(params[:q])
    @results = @p.result.order(day: :ASC)

    # CSV出力
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_reservation_csv(@results, params[:target_period])
      end
    end
  end

  def ranking
    # 商品のランキングデータの算出
    @product_count = Reservation.ransack(params[:q]).result.joins(:product_toppings).group(:product_id).count
    product_ids = Hash[@product_count.sort_by{ |_, v| -v}].keys # 配列でproduct_id [id,id,id]
    # ランキング順にproductデータを取得
    @product_ranking = Product.where(id: product_ids).order("field(id, #{product_ids.join(',')})")

    # トッピングのランキングデータの算出
    @results_product_toppings = ReservationsData.product_toppings(@p.result)
    topping_count_ary = @results_product_toppings.map {|p| p.toppings.map {|t| t.id}}
    @topping_count = topping_count_ary.flatten.group_by(&:itself).map{|key, value| [key, value.count]}.to_h
    topping_ids = Hash[@topping_count.sort_by{ |_, v| -v}].keys
    # ランキング順にtoppingデータを取得
    @topping_ranking = Topping.where(id: topping_ids).order("field(id, #{topping_ids.join(',')})")


    # CSV出力
    respond_to do |format|
      format.html
      format.csv do |csv|
        send_ranking_csv(@product_ranking, @product_count, @topping_ranking, @topping_count, params[:target_period])
      end
    end
  end

  private
  def search_reservation
    @p = Reservation.includes(:product_toppings).ransack(params[:q])
    # 検索対象期間
    @target_period = "#{params[:q][:day_gteq]}-#{params[:q][:day_lteq]}" if params[:q]

    # 検索対象期間を範囲オブジェクトで取得
    if params[:q] && params[:q][:day_gteq].blank? != true && params[:q][:day_lteq].blank? != true
      @target_period_range = params[:q][:day_gteq].to_date..params[:q][:day_lteq].to_date
    end
  end

  def send_sales_csv(target_period_start, target_period_end, reservations, target_period)
    target_period_range = target_period_start.to_date..target_period_end.to_date
    filename = "sales_#{target_period}.csv"
    csv_data = CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
      header = %w(日付 売上 来客数 テイクアウト数)
      csv << header
      target_period_range.each do |day|
        values = [day,
          ReservationsData.sales_for_target_day(reservations, day),
          ReservationsData.customers_for_target_day(reservations, day),
          ReservationsData.takeouts_for_target_day(reservations, day)
          ]
        csv << values
      end
    end
    send_data(csv_data, filename: filename)
  end

  def send_reservation_csv(reservations, target_period)
    filename = "reservation_#{target_period}.csv"
    csv_data = CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
      header = %w(氏名 来店日 来店時刻 予約日 人数 金額 商品)
      csv << header
      reservations.each do |reservation|
        values = [reservation.user.last_name + reservation.user.first_name,
          reservation.day,
          reservation.get_time_zone,
          reservation.created_at.to_s(:datetime_jp),
          reservation.get_count_person_value,
          reservation.total_price,
          reservation.get_product_toppings]
        csv << values
      end
    end
    send_data(csv_data, filename: filename)
  end

  def send_ranking_csv(product_ranking, product_count, topping_ranking, topping_count, target_period)
    filename = "ranking_#{target_period}.csv"

    csv_data = CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
      product_header = %w(順位 商品名 件数 販売金額)
      csv << product_header
      product_ranking.each do |ranking|
        values = [product_ranking.index(ranking) + 1, ranking.name, product_count[ranking.id],ranking.price * product_count[ranking.id]]
        csv << values
      end

      blank = %w( )
      csv << blank

      topping_header = %w(順位 トッピング名 件数 販売金額)
      csv << topping_header
      topping_ranking.each do |ranking|
        values = [topping_ranking.index(ranking) + 1, ranking.name, topping_count[ranking.id],ranking.price * topping_count[ranking.id]]
        csv << values
      end
    end
    send_data(csv_data, filename: filename)
  end
end
