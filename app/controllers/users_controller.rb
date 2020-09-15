class UsersController < ApplicationController
  before_action :ensure_correct_user
  before_action :check_test_user, only: :update

  def show
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    if Card.find_by(user_id: current_user.id).present?
      card = Card.find_by(user_id: current_user.id)
      customar = Payjp::Customer.retrieve(card.customer_token)
      @card = customar.cards.first
    end
    @address = current_user.address
    @reservations = current_user.reservations.order(created_at: :DESC)
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: "ユーザー情報を更新しました"
    else
      redirect_to user_path(current_user), alert: "ユーザー情報を更新できませんでした"
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :email, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday)
  end

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      flash[:alert] = "閲覧権限がありません"
      redirect_back(fallback_location: root_path)
    end
  end

  def check_test_user
    if current_user.email == "test@test.jp"
      redirect_to user_path(current_user), alert: "テストユーザーの為、編集できません"
    end
  end
end
