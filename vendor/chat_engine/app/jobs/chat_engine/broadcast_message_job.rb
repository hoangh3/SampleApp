module ChatEngine
  class BroadcastMessageJob < ApplicationJob
    queue_as :default

    def perform(message)
      # Do something later
      ActionCable.server.broadcast "chat_rooms_channel",
                                    { message: message, avatar: message.creator.name.first }
    end

    private

      def render_message(message)
        MessagesController.render partial: 'chat_engine/messages/message',
                                            locals: { message: message }
      end
  end
end
