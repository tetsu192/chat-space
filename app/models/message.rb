class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  mount_uploader :image, ImageUploader
  validates :text, presence: true, if: Proc.new{ |message| message.image.blank? }
  validates_presence_of :group_id, :user_id
end
