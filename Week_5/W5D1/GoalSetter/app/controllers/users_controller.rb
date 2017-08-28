class UsersController < ApplicationController
  def new
    render :new
  end

  def show
    render :show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.reset_token!
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
