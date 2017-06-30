var Message;
Message = function (arg) {
    this.text = arg.text, this.message_side = arg.message_side, this.avatar = arg.avatar;
    this.draw = function (_this) {
        return function () {
            var $message;
            $message = $($('.message_template').clone().html());
            $message.addClass(_this.message_side).find('.text').html(_this.text);
            $message.find('.avatar').html("<p style='position: absolute;display: inline-block;top: -30%;left: 32%;color: #d6d6d6;font-size: 29px;'>" + _this.avatar + "</p>")
            $('.messages').append($message);
            return setTimeout(function () {
                return $message.addClass('appeared');
            }, 0);
        };
    }(this);
    return this;
};

if ($('.messages').length > 0) {
  $('.messages').scrollTop($('.messages').prop("scrollHeight"))
}

App.chat_room = App.cable.subscriptions.create({
  channel: "ChatEngine::ChatRoomsChannel",
  chat_room_id: $('.messages').data('chat-room-id')
  }
  , {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    // $('.messages').append(data['message'])
    var message_side = data['message'].creator_id == $('.messages').data('current-user-id') ? 'right' : 'left'
    var  message = new Message({
          text: data['message'].content,
          avatar: data['avatar'],
          message_side: message_side
      });
    message.draw();
    $('.messages').scrollTop($('.messages').prop("scrollHeight"))
  },

  send_message: function(message) {
    this.perform('send_message', {
      message: message,
      current_user_id: $('.messages').data('current-user-id'),
      chat_room_id: $('.messages').data('chat-room-id')
    })
  }
});

(function () {
    var Message;
    Message = function (arg) {
        this.text = arg.text, this.message_side = arg.message_side;
        this.draw = function (_this) {
            return function () {
                var $message;
                $message = $($('.message_template').clone().html());
                $message.addClass(_this.message_side).find('.text').html(_this.text);
                $('.messages').append($message);
                return setTimeout(function () {
                    return $message.addClass('appeared');
                }, 0);
            };
        }(this);
        return this;
    };
    $(function () {
      var getMessageText, message_side, sendMessage;
      message_side = 'right';
      getMessageText = function () {
        var $message_input;
        $message_input = $('.message_input');
        return $message_input.val();
      };
      sendMessage = function (text) {
        var $messages, message;
        if (text.trim() === '') {
            return;
        }
        $('.message_input').val('');
        $messages = $('.messages');
        // message_side = message_side === 'left' ? 'right' : 'left';
        message_side = 'right'
        message = new Message({
            text: text,
            message_side: message_side
        });
        message.draw();
        return $messages.animate({ scrollTop: $messages.prop('scrollHeight') }, 300);
      };
      $('.send_message').click(function (e) {
        App.chat_room.send_message(getMessageText())
        $('.message_input').val('');
        // return sendMessage(getMessageText());
      });
      $('.message_input').keyup(function (e) {
        if (e.which === 13) {
          App.chat_room.send_message(getMessageText())
          $('.message_input').val('');
          // return sendMessage(getMessageText());
        }
      });
    });
}.call(this));

