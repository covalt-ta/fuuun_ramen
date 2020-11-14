class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    if message.save
      redirect_to room_path(message.room.reservation_id)
    else
      redirect_to room_path(message.room.reservation_id), alert: 'メッセージを送信できませんでした'
    end
  end

  private
  def message_params
    params.require(:message).permit(:message, :room_id).merge(user_id: current_user.id)
  end
end
