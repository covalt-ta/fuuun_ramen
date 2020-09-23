module PriceCalculator
  def self.total(product_toppings)
    # productの金額
    product_ids = product_toppings.pluck(:product_id)
    products = product_ids.map { |id| Product.find(id) }
    product_total_price = products.sum { |product| product[:price] }

    # toppingの金額
    toppings = product_toppings.map(&:toppings)
    topping_total = toppings.map { |topping| topping.sum { |topping| topping[:price]} }
    topping_total_price = topping_total.sum

    # productとtoppingの金額
    product_total_price + topping_total_price
  end
end
