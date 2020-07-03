require 'csv'
module Seeder
  class UserSeeder
    USERS_FILE = 'users.csv'.freeze
    def initialize(attrs)
      @attrs = attrs
    end

    def import
      user = User.find_or_initialize_by(username: @attrs[:username])
      user.update!(@attrs.except(:username))
    end

  def self.seed
    file_path = Rails.public_path.join('data', USERS_FILE)
    rows = CSV.foreach(file_path, CSV_OPTIONS) do |row|
      Seeder::UserSeeder.new(row.to_h).import
      end
    end
  end
end