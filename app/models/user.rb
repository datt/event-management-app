class User < ApplicationRecord
  ALLOWED_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ALLOWED_PHONE_REGEX = /.+/i # Keeping simple, Don't know the correct requirements
  # TODO: country to country varies, need to update the logic

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: ALLOWED_EMAIL_REGEX }
  validates :phone, presence: true, uniqueness: true, format: { with: ALLOWED_PHONE_REGEX }

  has_many :event_users
  has_many :events, through: :event_users, dependent: :destroy
end
