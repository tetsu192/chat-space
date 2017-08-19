class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :groups, through: :members
  has_many :members
  has_many :messages
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  scope :search_user, -> (key_word){where('name LIKE(?)', "%#{key_word}%").limit(10)}
  scope :without_me, -> (current_user_id){ where("id != ?", current_user_id) }

end
