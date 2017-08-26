class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :login!, :current_user

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login!(user)
    @current_user = user
    session_token = @current_user.reset_session_token!
    session[:session_token] = session_token
  end

  def logged_in?
    !!@current_user
  end

  def logout!
    @current_user.reset_session_token!
    session[:session_token] = nil
  end
end
