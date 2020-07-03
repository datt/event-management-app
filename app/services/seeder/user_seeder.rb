require 'csv'
# @author Datt Dongare
module Seeder
  class UserSeeder # Seeds the user data by reading CSV file
    USERS_FILE = 'users.csv'.freeze

    # @attr_reader attrs [Hash] csv row which is to be seeded into events
    attr_reader :attrs
    def initialize(attrs)
      @attrs = attrs
    end

    # Database import logic
    def import
      user = User.find_or_initialize_by(username: attrs[:username])
      user.update!(attrs.except(:username))
    end

  # Reads the csv and stores in respective tables
    def self.seed
      file_path = Rails.public_path.join('data', USERS_FILE)
      rows = CSV.foreach(file_path, CSV_OPTIONS) do |row|
        Seeder::UserSeeder.new(row.to_h).import
      end
    end
  end
end