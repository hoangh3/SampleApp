class CreateChatEngineMessageRecipients < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_engine_message_recipients do |t|
      t.integer :recipient_id, add_index: true
      t.integer :recipient_group_id, add_index: true
      t.belongs_to :message, add_index: true
      t.integer :is_read, limit: 1, default: 0

      t.timestamps
    end
  end
end
