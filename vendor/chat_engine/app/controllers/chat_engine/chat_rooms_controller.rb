require_dependency "chat_engine/application_controller"

module ChatEngine
  class ChatRoomsController < ApplicationController
    before_action :logged_in_user
    def show
      @chat_room_id = params[:id]
      @messages = Message.includes(:creator, message_recipients: :recipient).get_messages(current_user.id, @chat_room_id)
    end
  end
end
