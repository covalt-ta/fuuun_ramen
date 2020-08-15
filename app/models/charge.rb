class Charge
  def initialize
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
  end
  
  def create!(total_price, customer_token)
    Payjp::Charge.create(
      amount: total_price,
      customer: customer_token,
      currency: 'jpy'
    )
  end

  def self.create!(total_price, customer_token)
    charge = self.new
    charge.create!(total_price, customer_token)
  end
end