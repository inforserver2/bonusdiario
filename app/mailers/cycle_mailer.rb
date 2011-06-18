#encoding: UTF-8
class CycleMailer < ActionMailer::Base
  helper :cycles

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cycle_mailer.open.subject
  #
  def new_cycle cycle
    @cycle = cycle
    headers={:to => @cycle.contract.user.email1,:subject => "#{CFG['domain']} - Novo ciclo cadastrado id##{@cycle.id}."}
    headers['bcc']=@cycle.contract.user.email2 if @cycle.contract.user.email2
    mail(headers) 
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.cycle_mailer.close.subject
  #
  def close cycle
    @cycle = cycle
    headers={:to => @cycle.contract.user.email1,:subject => "#{CFG['domain']} - Ciclo concluído id##{@cycle.id}."}
    headers['bcc']=@cycle.contract.user.email2 if @cycle.contract.user.email2
    mail(headers) 
  end
end
