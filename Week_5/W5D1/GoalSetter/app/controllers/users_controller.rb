class UsersController < ApplicationController
  def index
    render :index
  end

  def new
    render :new
  end

  def show
    @user = current_user
    render :show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
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
