#encoding: UTF-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  before_filter :subdomain_filter, :modules

  layout "full"

  def subdomain_filter
    url = request.url
    subdomain = request.subdomains.last
    @sponsor = User.select([:id,:name,:nick,:visit, :gender_id, :avatar]).where(:name=>subdomain,:status=>1).first || User.select([:id,:name,:nick,:visit, :gender_id,:avatar]).first
    raise "there is no user" if @sponsor.nil?
    if subdomain!=@sponsor.name
      domain=URI.parse(root_url(:subdomain=>@sponsor.name))
      domain.path=request.path
      queries=request.query_string.split("&")
      queries<<"redir_from=#{subdomain}"
      domain.query=queries.join("&")
      redirect_to domain.to_s
    end
    if session[:sponsored].nil?
      @sponsor.visit=@sponsor.visit+1
      @sponsor.save(:validate=>false)
    end
    session[:sponsored] ||= true
    session[:redir_from] ||= params[:redir_from]
  end

  def require_login
    unless user_signed_in?
      flash[:error] = "Você deve estar logado para acessar este recurso"
      redirect_to sign_in_path
    end
    expire_session
  end

  def expire_session
    if user_signed_in?
      if Time.now > session[:logged][:expires_at]
        flash[:notice]="Sua sessão foi deslogada por inatividade. Faça o login novamente!"
        logout_user
      end
      inc_session_time 
    end
  end

  def modules
    @session=Session.new
    @user=User.new
  end
  

end
