#encoding: UTF-8
class Office::ApplicationController < ApplicationController

  before_filter :subdomain_filter,:require_login
  skip_before_filter :modules

  layout "member"

  def preliminar
    if current_user.status!=1
      flash[:notice]="Você deve ser um participante ativo para acessar este recurso!!!"
      redirect_to office_bill_path current_user.bills.first.token
    end
  end

end
