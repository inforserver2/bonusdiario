#encoding: UTF-8
class UserMailer < ActionMailer::Base


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)

    @user = user

    headers={:to => user.email1,:subject => "#{CFG['domain']} - Seja bem vindo(a)."}
    headers['bcc']= @user.email2 if @user.email2

    mail(headers)

  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.sponsor.subject
  #
  def sponsor(user,level)
   
    @user = user
    @level=level
    @sponsor = case level
    when 1 then user.sponsor
    when 2 then user.sponsor.sponsor
    when 3 then user.sponsor.sponsor.sponsor
    when 4 then user.sponsor.sponsor.sponsor.sponsor
    when 5 then user.sponsor.sponsor.sponsor.sponsor.sponsor
    else
      nil
    end

    headers={:to => @sponsor.email1,
             :subject => "#{CFG['domain']} - Novo indicado em seu nível##{level}."}
    headers['bcc']= @sponsor.email2 if @sponsor.email2
    
    mail(headers)

  end
end
