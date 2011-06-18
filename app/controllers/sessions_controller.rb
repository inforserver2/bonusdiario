#encoding: UTF-8
class SessionsController < ApplicationController

  layout "full"
  def new
    @session=Session.new
  end

  def create
    Session.attr_accessible :name,:password 
    @session=Session.new params[:session]
    @session.profile=1
    respond_to do |format|
      if @session.valid?
        make_session(@session)
        format.html { redirect_to office_welcome_path, success: 'Sessão iniciada com sucesso.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    if session[:logged].any?
      flash[:success]="Sessão deslogada com sucesso"
      logout_user
    end
  end


  def password
      @session=Session.new
  end

  def password_send

    Session.attr_accessible :email

    @session=Session.new params[:session]

    @session.profile=2
    respond_to do |format|
      if @session.valid?
        flash[:success]="Os dados foram foram enviados para seu email."
        @session.auth_email.each do |user|
          SiteMailer.delay.password(user)
        end
        format.html { redirect_to action: "password" }
      else
        format.html { render action: "password" }
      end
    end
  end



end
