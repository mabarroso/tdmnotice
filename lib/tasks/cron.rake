namespace :cron do
  desc "Notify 5 followers"
  task :notify => :environment do
    puts 'hola'
  end
end