class Message < ApplicationRecord
  belongs_to :user
  belongs_to :group
  mount_uploader :image, ImageUploader
  validates :text, presence: true, if: Proc.new{ |a| a.image.blank? }
end
