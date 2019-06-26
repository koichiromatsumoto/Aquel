class RoomsController < ApplicationController
	before_action :authenticate_user!

  def index
  	@room = Room.new
    @rooms = Room.joins(:messages).includes(:messages).all.order("messages.created_at" => :desc)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
  end

  def create
  	@room = Room.new(room_params)
    @rooms = Room.joins(:messages).includes(:messages).all.order("messages.created_at" => :desc)
    @room.user_id = current_user.id
  	if @room.save
  	  redirect_to room_path(@room)
    else
      flash.now[:danger] = "ルーム名は1〜16文字で入力してください"
      render :index
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.destroy
      flash[:success] = "ルームを削除しました"
      redirect_to rooms_path
    else
      flash[:danger] = "ルームの削除に失敗しました"
      redirect_to room_path(@room.id)
    end
  end

  private
  def room_params
  	params.require(:room).permit!
  end
end
