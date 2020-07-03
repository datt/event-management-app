# @author Datt Dongare
class EventUser < ApplicationRecord # For user and event relation
  # This is many to many association between user and event
  # Associations
  belongs_to :event
  belongs_to :user

  # Validations
  validates :user, presence: true
  validates :event, presence: true
  validates :rsvp, presence: true
  validates :user, uniqueness: { scope: :event } # One user can attend an event once

  # before_create :downcase_rsvp
  before_save :auto_cancel_overlapping_event

  private

  # To make sure of sanitizing data properly to handle logic in better way
  def downcase_rsvp
    self.rsvp = rsvp.downcase
  end

  # This cancels all the overlapping events of an user if current rsvp is yes
  # considers both scenario of allday event or not allday event
  def auto_cancel_overlapping_event
    if self.rsvp == 'yes'
      event = self.event
      EventUser.joins(:event).where(user_id: self.user_id)
               .where("events.starttime >= ? AND (events.endtime <= ? OR events.allday = ?) ", event.starttime, event.starttime.end_of_day, true)
               .update_all(rsvp: 'no')
      EventUser.joins(:event).where(user_id: self.user_id)
               .where("events.starttime >= ? AND (events.endtime <= ? OR events.allday = ?) ", event.starttime, event.endtime, false)
               .update_all(rsvp: 'no')

    end
  end
end
