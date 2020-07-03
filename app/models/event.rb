class Event < ApplicationRecord
  validates :title, presence: true
  validates :starttime, presence: true
  validates :endtime, presence: true, unless: :allday

  belongs_to :creator, class_name: "User"
  has_many :event_users
  has_many :users, through: :event_users, dependent: :destroy

  scope :between_dates, -> (start_date, end_date) {
    start_time = DateTime.parse(start_date).beginning_of_day
    end_time = DateTime.parse(end_date).end_of_day

    all_day = where(allday: true)
              .where('(events.starttime > ? AND events.endtime < ?)',
    start_time, start_time)

    non_all_day = where(allday: false)
                  .where('(events.starttime > ? AND events.endtime < ?)',
    start_time, end_time)

    all_day.or(non_all_day)
  }
end