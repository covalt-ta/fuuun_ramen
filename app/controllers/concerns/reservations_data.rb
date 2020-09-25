module ReservationsData

  # 来客数合計を算出する
  def self.count_person(reservations)
    reservations.sum { |reservation| reservation.get_count_person_value }
  end

  # Take Out数を算出する
  def self.count_takeout(days)
    Reservation.where(day: days, count_person_id: 1).count
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
end
