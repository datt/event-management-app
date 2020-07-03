# @author Datt Dongare
class RsvpParser # Parses event of csv row
  EVENT_SEPERATOR = ';'.freeze
  USERNAME_SEPERATOR = '#'.freeze

  attr_reader :rsvp
  # @param rsvp [String]
  # @example 'brian#no;kourtney#yes;bob#maybe'
  def initialize(rsvp)
    @rsvp = rsvp
  end

  # @return [Array] array of hash
  # @example [{ username: 'brian', rsvp: 'no'}, { username: 'bob', rsvp: 'maybe'}]
  def parse
    return {} unless rsvp.present?
    # TODO: Update with regex logic maybe
    rsvp.split(EVENT_SEPERATOR).map do |event_string|
      username, rsvp = event_string.split(USERNAME_SEPERATOR)
      { username: username, rsvp: rsvp}
    end
  end
end