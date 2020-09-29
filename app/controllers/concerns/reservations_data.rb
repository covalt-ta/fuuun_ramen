module ReservationsData

  # 来客数合計を算出する
  def self.count_person(reservations)
    reservations.sum { |reservation| reservation.get_count_person_value }
  end

  # product_toppingsを取得する
  def self.product_toppings(reservations)
    # 今月の予約に紐づく全てのproduct_topping.idを取得
    product_topping_ids = reservations.map {|reservation| reservation.order_record_products.map {|order| order.product_topping.id}}
    # ネストされた配列の値を平滑化
    product_topping_ids = product_topping_ids.flatten
    # procut_toppingsを取得
    ProductTopping.where(id: product_topping_ids)
  end

  # 複数予約からdayに紐づく全ての予約を取得
  def self.for_target_day(reservations, day)
    reservations.where(day: day)
  end

  # 複数予約から対象日の合計金額を取得する
  def self.sales_for_target_day(reservations, day)
    target_reservations = self.for_target_day(reservations,day)
    target_product_toppings = self.product_toppings(target_reservations)
    PriceCalculator.total(target_product_toppings)
  end

  # 複数予約から対象日の来客数を取得する
  def self.customers_for_target_day(reservations, day)
    target_reservations = self.for_target_day(reservations,day)
    ReservationsData.count_person(target_reservations)
  end

  # 複数予約から対象日のテイクアウト数を取得する
  def self.takeouts_for_target_day(reservations, day)
    target_reservations = self.for_target_day(reservations,day)
    target_reservations.where(count_person_id: 1).count
  end

end
