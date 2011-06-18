#encoding: UTF-8
namespace :reboot do

  desc "Notice admin when computer restarts"
  task :observer => :environment  do

    puts "reboot:observer #{Time.now}"    
    SiteMailer.delay.monitor("Finalmente houve um leve descanso...para refrescar a memória... mas to na ativa novamente!","Servidor reiniciado em #{Time.now.to_s_br}")
  end



end

