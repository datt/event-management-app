# @author Datt Dongare
class RsvpParser # Parses event of csv row
  EVENT_SEPERATOR = ';'.freeze
  USERNAME_SEPERATOR = '#'.freeze

  attr_reader :rsvp
  def initialize(rsvp)
    @rsvp = rsvp
  end

  def parse
    return {} unless rsvp.present?
    # TODO: Update with regex logic maybe
    rsvp.split(EVENT_SEPERATOR).map do |event_string|
      username, rsvp = event_string.split(USERNAME_SEPERATOR)
      { username: username, rsvp: rsvp}
    end
  end
end