# encoding: UTF-8
class CommMailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comm_mailer.new.subject
  #

  def new_comm(comm)
    @comm=comm
    headers={:to => comm.user.email1,:subject => "#{CFG['domain']} - você recebeu uma nova comissão ##{comm.comm_type.name}."}
    headers['bcc']=comm.user.email2 if comm.user.email2

    mail(headers)
  end


end
