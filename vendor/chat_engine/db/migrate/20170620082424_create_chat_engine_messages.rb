class CreateChatEngineMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_engine_messages do |t|
      t.integer :creator_id, add_index: true
      t.string :content

      t.timestamps
    end
  end
end
