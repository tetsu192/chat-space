class Member < ApplicationRecord
  belongs_to :user
  belongs_to :group

  scope :without_me, -> (current_user_id){ where("user_id != ?", current_user_id) }

end
