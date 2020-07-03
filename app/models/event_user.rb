class EventUser < ApplicationRecord
  # Associations
  belongs_to :event
  belongs_to :user

  # Validations
  validates :user, presence: true
  validates :event, presence: true
  validates :rsvp, presence: true

  # before_create :downcase_rsvp
  before_save :auto_cancel_overlapping_event

  private

  def downcase_rsvp
    self.rsvp = rsvp.downcase
  end

  def auto_cancel_overlapping_event
    if self.rsvp == 'yes'
      event = self.event
      EventUser.joins(:event).where(user_id: self.user_id)
               .where("events.starttime >= ? AND (events.endtime <= ? OR events.allday = ?) ", event.starttime, event.starttime, true)
               .update_all(rsvp: 'no')

    end
  end
end
