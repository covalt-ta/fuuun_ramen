class AddressesController < ApplicationController
  before_action :set_address, only: %i(update destroy)

  def new
    @address =  Address.new
  end

  def create
    if current_user.create_address(address_params)
      redirect_to user_path(current_user), notice: 'ご住所を登録できました'
    else
      redirect_to action: :new, alert: 'ご住所の登録に失敗しました'
    end
  end

  def update
    if @address.update(address_params)
      redirect_to user_path(current_user), notice: 'ご住所を更新しました'
    else
      redirect_to user_path(current_user), notice: 'ご住所の更新に失敗しました'
    end
  end

  def destroy
    if @address.destroy
      redirect_to user_path(current_user), notice: 'ご住所の登録を削除しました'
    else
      redirect_to user_path(current_user), notice: 'ご住所の登録削除に失敗しました'
    end
  end

  private
  def address_params
    params.require(:address).permit(:postal_code, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id)
  end

  def set_address
    @address = current_user.address
  end
end
