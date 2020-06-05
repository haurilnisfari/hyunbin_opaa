class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, length: {minimum: 3}
  validates :username, presence: true, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, confirmation: { case_sensitive: true }
  validates :password_confirmation, presence: true
end
