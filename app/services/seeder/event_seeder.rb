require 'csv'
module Seeder
  class EventSeeder
    EVENTS_FILE = 'events.csv'.freeze
    EVENT_PENDING_FIELDS = %i(description allday)

    attr_reader :attrs, :row_index
    def initialize(attrs, row_index)
      @attrs = attrs
      @row_index = row_index
    end

    def import
      users_id_rsvp = user_id_with_rsvp
      unless users_id_rsvp.present?
        Seeder.log("User/data #{users_id_rsvp} not present at #{row_index}")
        return
      end
      puts users_id_rsvp.first
      import_event(users_id_rsvp.first)
      import_event_users(users_id_rsvp)
    end

    def import_event(user_id_rsvp)
      @event = Event.find_or_initialize_by(title: attrs[:title], creator_id: user_id_rsvp[:user_id])
      @event.starttime = DateTime.parse(attrs[:starttime])
      # NOTE:  We can ignore this field, still storing
      if attrs[:allday] == 'true'
        @event.endtime = nil
      else
        @event.endtime = DateTime.parse(attrs[:endtime])
      end
      @event.update!(attrs.slice(*EVENT_PENDING_FIELDS))
    end

    def user_id_with_rsvp
      return {} unless attrs[:usersrsvp].present?
      uname_with_rsvp = RsvpParser.new(attrs[:usersrsvp]).parse
      user_names = uname_with_rsvp.map { |usvp| usvp[:username] }
      users = User.where(username: user_names).to_a
      uname_with_rsvp.each_with_object([]) do |uname_rsvp_hash, new_array|
        # Finding user with ruby find method
        user = users.find { |u| u.username == uname_rsvp_hash[:username] }
        if user.present?
          new_array << { user_id: user.id, rsvp: uname_rsvp_hash[:rsvp] }
        else
          Seeder.log("User #{uname_rsvp_hash[:username]} not present at #{row_index}")
        end
        new_array
      end
    end

    def import_event_users(users_id_rsvp)
      users_id_rsvp.each do |user_id_rsvp|
        event_user = @event.event_users.find_or_initialize_by(user_id: user_id_rsvp[:user_id])
        event_user.update!(rsvp: user_id_rsvp[:rsvp])
      end
    end

    class << self
      def seed
        file_path = Rails.public_path.join('data', EVENTS_FILE)
        rows = CSV.foreach(file_path, CSV_OPTIONS).with_index(1) do |row, row_index|
          Seeder::EventSeeder.new(row.to_h, row_index).import
        end
      end
    end
  end
end