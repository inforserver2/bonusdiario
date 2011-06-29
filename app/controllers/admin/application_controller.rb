#encoding: UTF-8
class Admin::ApplicationController < Office::ApplicationController

  before_filter :permission

  def permission
    unless current_user.admin?
      flash[:notice]="Você não tem privilegios para acessar este recurso!"
      redirect_to office_welcome_path 
    end
  end

end
