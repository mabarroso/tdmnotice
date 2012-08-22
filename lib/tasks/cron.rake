namespace :cron do
  desc "Notify 5 followers"
  task :notify => :environment do
    require 'cron_tasks'
    include Cron
		Cron::Tasks.notify
  end
end