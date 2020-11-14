class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_two_days_ago
  before_action :set_room_or_move, only: :show

  def index
    # 今日から2日前以降の予約を取得
    @reservations = current_user.reservations.where('day >= ?', @two_days_ago).order(day: "ASC").includes(product_toppings: :product)
  end

  def show
    move_to_index_for_expired
    @message = Message.new
    @messages = Message.where(room_id: @room.id)
    @reservation = @room.reservation
    @products = @reservation.product_toppings
  end

  private
  def get_two_days_ago
    @two_days_ago = Date.today - 2
  end

  def set_room_or_move
    # ログインユーザーの予約に紐づくルームへのアクセスでない場合、リダイレクト
    unless Reservation.exists?(params[:id]) || Reservation.find(params[:id]).user_id != current_user.id
      redirect_to rooms_path, alert: 'メッセージルームに入れませんでした'
    end

    #予約に紐づくルームを@roomに定義
    @room = Room.find_by(reservation_id: params[:id])

    # roomが存在するか判定し、存在しない場合にreservation_idを渡して作成する
    if @room.nil?
      @room = Room.new(reservation_id: params[:id])
      redirect_to rooms_path, alert: 'メッセージルームに入れませんでした' unless @room.save
    end
  end

  def move_to_index_for_expired
    # 来店日を３日間以降過ぎている場合、ルーム一覧へリダイレクト
    if @room.reservation.day < @two_days_ago
      redirect_to rooms_path and return
    end
  end
end
