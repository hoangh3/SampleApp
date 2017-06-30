module ChatEngine
  class Message < ApplicationRecord
    after_create_commit { ChatEngine::BroadcastMessageJob.perform_later(self) }

    belongs_to :creator, class_name: User, foreign_key: :creator_id
    has_many :message_recipients

    scope :get_messages, -> (creator_id, recipient_id) {
      joins(:message_recipients)
      .where("(chat_engine_messages.creator_id = ? AND
        chat_engine_message_recipients.recipient_id = ?) OR
        (chat_engine_messages.creator_id = ? AND
        chat_engine_message_recipients.recipient_id = ?)",
        creator_id, recipient_id, recipient_id, creator_id)
      .order(id: :asc)
    }
  end
end
