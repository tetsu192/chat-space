class Message < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  validates :text, presence: true
end
