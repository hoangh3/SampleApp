class CreateChatEngineUserGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_engine_user_groups do |t|
      t.belongs_to :group, add_index: true
      t.integer :user_id, add_index: true

      t.timestamps
    end
  end
end
