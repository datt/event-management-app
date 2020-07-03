class EventUser < ApplicationRecord
  # Associations
  belongs_to :event
  belongs_to :user

  # Validations
  validates :user, presence: true
  validates :event, presence: true
  validates :rsvp, presence: true

  before_save :auto_cancel_overlapping_event

  private

  def auto_cancel_overlapping_event
    # auto cancel logic
  end
end
