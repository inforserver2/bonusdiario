#encoding: UTF-8
namespace :remember do

  load 'my_tools.rb'

  desc "Send mail remembers for pending bills"
  task :start => :environment  do

    billings=Bill.where(:status=>0, :created_at=>(Date.today-16.days)..(Date.today))
    message="<h2>Relatório</h2><br>"
    arr=[]
    billings.each do |bill|

        day = MyTools.bill_remember_days(MyTools.diff_date_in_days(bill.created_at,Time.now))
        if MyTools.bill_remember_days_interval.include? day
          puts m1="Enviando lembrete de conta id##{bill.id} versão #{day}"
          arr <<  m1
          BillMailer.delay.remember(bill)
        end
    end
    message+=arr.join("<br>")
    SiteMailer.delay.monitor(message,"Enviando lembretes de contas pendentes para o dia #{Time.now.to_s_br}")
  end



end

