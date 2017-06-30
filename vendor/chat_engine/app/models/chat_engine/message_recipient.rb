module ChatEngine
  class MessageRecipient < ApplicationRecord
    belongs_to :recipient, class_name: User, foreign_key: :recipient_id
    belongs_to :recipient_group, class_name: UserGroup, foreign_key: :recipient_group_id, optional: true
    belongs_to :message
  end
end
