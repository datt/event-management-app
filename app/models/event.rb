class Event < ApplicationRecord
  validates :title, presence: true
  validates :starttime, presence: true
  validates :endtime, presence: true, unless: :allday

  belongs_to :creator, class_name: "User"
  has_many :event_users
  has_many :users, through: :event_users, dependent: :destroy
end
