# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
#
# update crontab running: whenever --update-crontab -s environment=development project

set :output, "log/cron.log"
env :PATH, '/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'
job_type :rake, "cd :path && RAILS_ENV=:environment /usr/local/bin/rake :task :output"
job_type :runner,  'cd :path && script/rails runner -e :environment ":task" :output'

every :reboot do
  rake "reboot:observer"                        
  rake "jobs:work"
end

every 1.day,:at=>"1am" do
 rake "backuping:start"
end

every 1.day,:at=>"2am" do
  rake "remember:start"
end

every :wednesday,:at=>"3am" do
  rake "payout:generator"
end

every 1.minute do
  runner "CarrierWave.clean_cached_files!"
end
