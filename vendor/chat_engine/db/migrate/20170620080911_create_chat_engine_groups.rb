class CreateChatEngineGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_engine_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
