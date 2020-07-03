class User < ApplicationRecord
  ALLOWED_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ALLOWED_PHONE_REGEX = /.+/i # Don't know the correct requirements

  validates :username, presence: true
  validates :email, presence: true, format: { with: ALLOWED_EMAIL_REGEX }
  validates :phone, presence: true, format: { with: ALLOWED_PHONE_REGEX }

  has_many :event_users
  has_many :events, through: :event_users, dependent: :destroy
end
