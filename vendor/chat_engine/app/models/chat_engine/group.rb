module ChatEngine
  class Group < ApplicationRecord
    have_many :user_group
  end
end
