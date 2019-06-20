class RoomsController < ApplicationController
	before_action :authenticate_user! # Deviseのログイン確認

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
    @room.user_id = current_user.id
  	@room.save
  	redirect_to room_path(@room)
  end

  def destroy
  end

  private
  def room_params
  	params.require(:room).permit!
  end
end
