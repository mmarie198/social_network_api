class User < ApplicationRecord
      has_many :posts, dependent: :destroy
  
  validates :username, presence: true
  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
