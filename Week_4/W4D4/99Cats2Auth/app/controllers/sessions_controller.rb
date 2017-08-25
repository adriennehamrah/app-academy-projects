class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    if user.nil?
      flash.now[:errors] = ["crendentials were wrong"]
      render :new
    else
      login_user!(user)
      redirect_to cats_url
      session_token = user.reset_session_token!
      session[:session_token] = session_token
    end
  end

  def destroy

    if current_user
      current_user.reset_session_token!
      logout!
      session[:session_token] = nil
      redirect_to cats_url
    end
  end

end
