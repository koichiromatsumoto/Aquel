document.addEventListener 'turbolinks:load', ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: $('#messages').data('room_id') },
    connected: ->

    disconnected: ->

    received: (data) ->
      $('#messages').append data['message']

    speak: (message)->
      # 空での押下防止
      unless message is ""
        # フォーム内のメッセージをサーバー側(channel)のspeakメソッドに送り呼び出す
        @perform 'speak', message: message

  # エンターキーを押下した時にApp.room.speakイベントが発火
  $(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
    if event.keyCode is 13 # return = send
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()