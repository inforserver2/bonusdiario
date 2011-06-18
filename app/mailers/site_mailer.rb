#encoding: UTF-8
class SiteMailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.site_mailer.contact.subject
  #
  def contact contact
    @contact = contact
    headers={:to => CFG['email-contact'], :subject => "#{CFG['domain']} - Contato"}
    mail(headers)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.site_mailer.support.subject
  #
  def support support
    @support = support
    @user = User.find(support[:user_id])
    headers={:to => CFG['email-support'], :subject => "#{CFG['domain']} - Suporte"}
    headers['reply_to']="#{@user.email1}"
    headers['reply_to']+=";#{@user.email2}" if @user.email2

    mail(headers)
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.site_mailer.password.subject
  #
 def password(user)
    @user = user
    headers={:to => user.email1,:subject => "#{CFG['domain']} - Dados"}
    headers['bcc']=user.email2 if user.email2

    mail(headers)
  end

 def monitor(msg,subject)
    @msg = msg
    headers={:to => CFG['email-support'], :subject => "#{CFG['domain']} - #{subject}"}
    mail(headers)

 end

end
