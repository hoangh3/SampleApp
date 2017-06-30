module ChatEngine
  class ChatRoomsChannel < ApplicationCable::Channel
    def subscribed
      # stream_from "some_channel"
      stream_from "chat_rooms_channel"
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end

    def send_message(data)
      ActiveRecord::Base.transaction do
        message = Message.create(content: data['message'], creator_id: data['current_user_id'])
        message.message_recipients.build(recipient_id: data['chat_room_id']).save
      end
    end
  end
end
