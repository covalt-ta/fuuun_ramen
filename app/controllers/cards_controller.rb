class CardsController < ApplicationController
  before_action :authenticate_user!
  def new
  end

  def create
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer = Payjp::Customer.create(
      description: 'test',
      card: params[:card_token]
    )
    card = Card.new(
      card_token: params[:card_token],
      customer_token: customer.id,
      user_id: current_user.id
    )
    if card.save
      redirect_to user_path(current_user)
    else
      redirect_to :new
    end
  end

  def destroy
    card = Card.find_by(user_id: current_user.id)
    if card.destroy
      redirect_to user_path(current_user), notice: 'クレジットカードの登録を削除しました'
    else
      redirect_to user_path(current_user), alert: 'クレジットカードの登録を削除できませんでした'
    end
  end
end
