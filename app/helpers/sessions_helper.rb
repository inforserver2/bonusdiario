module SessionsHelper
  extend ActiveSupport::Memoizable
  SESSION_TIME=10.minutes.from_now

  def current_user
    if user_signed_in?
         User.find_by_token(session[:logged][:user][:token])
    end
  end

  def user_signed_in?
     session[:logged].present? && session[:logged].any?
  end

  memoize :current_user

  private

  def logout_user
      session[:logged]={}
      redirect_to sign_in_path
  end

  def inc_session_time
    if session[:logged].any?
      session[:logged][:expires_at]=SESSION_TIME
    end
  end

  def make_session(user)
    session[:logged]={:user=>{:token=>user.token},:expires_at=>SESSION_TIME}
  end


end
