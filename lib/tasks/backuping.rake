#encoding: UTF-8
namespace :backuping do

  desc "file and database backups to an user directory"
  task :start => :environment  do
    puts "backuping:start #{Time.now}"    
    system("/usr/local/bin/astrails-safe -v -L /var/web/tipegoo.com/config/astrails.rb")
  end



end

