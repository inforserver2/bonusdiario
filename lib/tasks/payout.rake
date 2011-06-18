#encoding: UTF-8
namespace :payout do

  desc "Generate the payouts for qualified commissioned users"
  task :generator => :environment  do

    users=User.includes(:comms).where({:comms=>{:status=>0,:payout_id=>nil}})
    message="<h2>Relatório</h2><br>"
    arr=[]
    users.each do |user|
        total = user.comms.map(&:value).sum
        if total >= 10
          puts m1="Gerando ordem de comissão para #{user.name} no valor de #{total.reais_contabeis}"
          arr <<  m1
          user.payouts.create(:value=>total,:mail=>true)
        end
    end
    message+=arr.join("<br>")
    SiteMailer.delay.monitor(message,"Gerando ordem de comissões para o dia #{Time.now.to_s_br}")
  end



end

