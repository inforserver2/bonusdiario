#encoding: UTF-8
class PayoutMailer < ActionMailer::Base

  helper :payouts
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.payout_mailer.payout_new.subject
  #
  def payout_new payout
    @payout = payout
    headers={:to => @payout.user.email1,:subject => "#{CFG['domain']} - Você recebeu uma nova ordem de comissionamento id##{@payout.id}."}
    headers['bcc']=@payout.user.email2 if @payout.user.email2

    mail(headers) 
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.payout_mailer.payout_sent.subject
  #
  def payout_sent payout
    @payout = payout
    headers={:to => @payout.user.email1,:subject => "#{CFG['domain']} - Transferência concluída da ordem de comissionamento id##{@payout.id}."}
    headers['bcc']=@payout.user.email2 if @payout.user.email2

    mail(headers) 
  end
end
