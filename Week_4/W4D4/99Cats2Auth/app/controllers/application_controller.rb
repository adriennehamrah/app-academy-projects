class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :login_user!, :logged_in?

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def login_user!(user)
    @current_user = user
    session[:session_token] = user.session_token
  end

  def logout!
    session[:session_token] = nil
    @current_user = nil
  end

  def redirect_if_logged_in
    redirect_to cats_url if logged_in?
  end

  def redirect_unless_logged_in
    redirect_to cats_url unless logged_in?
  end
end
