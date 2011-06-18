#encoding: UTF-8
class BillMailer < ActionMailer::Base
  load 'my_tools.rb' 
  helper :billings
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.bill_mailer.billing.subject
  #
  def billing bill
    
    @bill = bill
    
    headers={:to => bill.contract.user.email1,
             :subject => "#{CFG['domain']} - Cópia fatura de pagamento N##{@bill.id}."}
    headers['bcc']= bill.contract.user.email2 if bill.contract.user.email2

    mail(headers)

  end

  def remember bill
    
    @bill = bill
    diff = MyTools.diff_date_in_days bill.created_at, Time.now
    day = MyTools.bill_remember_days diff
    
    headers={:to => bill.contract.user.email1,
             :subject => "#{CFG['domain']} - Lembrete (#{day}/5) de fatura pendente N##{@bill.id}."}
    headers['bcc']= bill.contract.user.email2 if bill.contract.user.email2

    mail(headers)

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.bill_mailer.receipt.subject
  #
  def receipt bill
    
    @bill = bill
    
    headers={:to => bill.contract.user.email1,
             :subject => "#{CFG['domain']} - Recibo para a fatura N##{@bill.id}."}
    headers['bcc']= bill.contract.user.email2 if bill.contract.user.email2

    mail(headers)
  end
end
