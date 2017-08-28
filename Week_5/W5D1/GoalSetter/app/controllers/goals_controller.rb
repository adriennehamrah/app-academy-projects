class GoalsController < ApplicationController
  def new
    render :new
  end

  def show
    @goal = Goal.find(params[:id])
    render :show
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = current_user.goals.find(params[:id])
    @goal.update(goal_params)
    flash[:errors] = @goal.errors.full_messages
    redirect_to goal_url(@goal)
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy
    redirect_to user_url(current_user)
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :details, :private, :complete)
  end
end
