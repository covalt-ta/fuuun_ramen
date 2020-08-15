class ChargesController < ApplicationController
  def create
    redirect_to new_card_path and return unless current_user.card.present?
    
    product_ids = params[:product_ids].map(&:to_i)
    current_user.checkout!(product_ids: product_ids)

    redirect_to root_path, notice: '決済に成功しました'
  end
end