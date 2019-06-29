class RoomChannel < ApplicationCable::Channel
  def subscribed
  	# そのルームを購読している全てのユーザにメッセージをブロードキャストする
    stream_from "room_channel_#{params['room_id']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
  	# 受け取ったメッセージとその他情報をdbへ
    Message.create!(content: data['message'], user_id: current_user.id, room_id: params['room_id'])
  end
end
