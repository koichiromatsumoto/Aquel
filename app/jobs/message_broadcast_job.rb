class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # channelでcreateされたmessageをクライアントにブロードキャスト
  def perform(message)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", message: render_message(message)
  end

  private
    # application_controllerで定義したメソッドでrender
    def render_message(message)
      ApplicationController.render_with_signed_in_user(message.user, partial: 'messages/message', locals: { message: message })
    end
end
