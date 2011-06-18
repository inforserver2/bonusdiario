#encoding: UTF-8
namespace :testing do

  desc "just a testing that sends a notice to admin"
  task :send => :environment  do
    puts "testing:send #{Time.now}"    
    SiteMailer.delay.monitor("Olá admin tudo bem? ","Teste de comunicação com o administrador")
  end



end

