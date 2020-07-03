module Seeder
  CSV_OPTIONS = { header_converters: :symbol, headers: true }
  LOG_TIME_FORMAT = "%d-%m-%Y %H:%M:%S".freeze

  def self.seed
    puts 'Seeding users...'
    Seeder::UserSeeder.seed
    puts 'Seeding events...'
    Seeder::EventSeeder.seed
  end

  def self.log(text)
    date_time = DateTime.now.strftime(LOG_TIME_FORMAT)
    Rails.logger.info "Seeding #{date_time} ---> #{text}"
  end
end