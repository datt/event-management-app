require 'csv'
# @author Datt Dongare
module Seeder
  class EventSeeder # Seeds the event and associated data by reading CSV file
    EVENTS_FILE = 'events.csv'.freeze
    EVENT_PENDING_FIELDS = %i(description allday)

    attr_reader :attrs, :row_index
    # @attr_reader attrs [Hash] csv row which is to be seeded into events
    # @attr_reader row_index [Integer] row number to identify the errors if any

    def initialize(attrs, row_index)
      @attrs = attrs
      @row_index = row_index
    end

    # Database import logic
    def import
      users_id_rsvp = fetch_user_id_with_rsvp
      unless users_id_rsvp.present?
        Seeder.log("User/data #{users_id_rsvp} not present at #{row_index}")
        return
      end
      import_event(users_id_rsvp.first) # Assumed first to be creator of event
      import_event_users(users_id_rsvp)
    end

    # Stores the data in events table
    # @param user_id_rsvp [Hash]
    # @example { user_id: 1, rsvp: 'yes' }
    def import_event(user_id_rsvp)
      @event = Event.find_or_initialize_by(title: attrs[:title], creator_id: user_id_rsvp[:user_id])

      @event.starttime = DateTime.parse(attrs[:starttime])
      if attrs[:allday] == 'true'
        @event.endtime = nil
        @event.completed = true if @event.starttime.end_of_day <= DateTime.now
      else
        @event.endtime = DateTime.parse(attrs[:endtime])
        @event.completed = true if @event.endtime <= DateTime.now
      end
      @event.update!(attrs.slice(*EVENT_PENDING_FIELDS))
    end

    # This generates new Array of hash which has user_id and rsvp as keys
    # @return [Array] array of hash
    # @example [{ user_id: 1, rsvp: 'yes' }, { user_id: 3, rsvp: 'no' }]
    def fetch_user_id_with_rsvp
      return {} unless attrs[:usersrsvp].present?
      uname_with_rsvp = RsvpParser.new(attrs[:usersrsvp]).parse
      user_names = uname_with_rsvp.map { |usvp| usvp[:username] }
      # Fetching in single query to improve performance
      users = User.where(username: user_names).to_a
      uname_with_rsvp.each_with_object([]) do |uname_rsvp_hash, new_array|
        # Finding user with ruby's find method,
        # not to be confused with ActiveRecord's find
        user = users.find { |u| u.username == uname_rsvp_hash[:username] }
        if user.present?
          new_array << { user_id: user.id, rsvp: uname_rsvp_hash[:rsvp] }
        else
          Seeder.log("User #{uname_rsvp_hash[:username]} not present at #{row_index}")
        end
        new_array
      end
    end

    # Stores data in event_users table
    # @param users_id_rsvp [Array] array of hash
    # @example [{ user_id: 1, rsvp: 'yes' }, { user_id: 3, rsvp: 'no' }]
    def import_event_users(users_id_rsvp)
      users_id_rsvp.each do |user_id_rsvp|
        event_user = @event.event_users.find_or_initialize_by(user_id: user_id_rsvp[:user_id])
        event_user.update!(rsvp: user_id_rsvp[:rsvp])
      end
    end

    class << self
      # Reads the csv and stores in respective tables
      def seed
        file_path = Rails.public_path.join('data', EVENTS_FILE)
        rows = CSV.foreach(file_path, CSV_OPTIONS).with_index(1) do |row, row_index|
          Seeder::EventSeeder.new(row.to_h, row_index).import
        end
      end
    end
  end
end