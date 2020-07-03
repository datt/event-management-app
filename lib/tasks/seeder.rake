namespace :seeder do
  desc 'This feeds data from CSV'
  task run: :environment do
    puts "Seeding ...."
    Seeder.seed
    puts "Seeding done!"
  end
end