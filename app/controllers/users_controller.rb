class UsersController < ApplicationController
  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if Card.find_by(user_id: current_user.id).present?
      card = Card.find_by(user_id: current_user.id)
      customar = Payjp::Customer.retrieve(card.customer_token)
      @card = customar.cards.first
    end
  end
end
