class GoalcommentsController < ApplicationController
  def create
    goal_comment = Goalcomment.new(comment_params)
    goal_comment.goal_id = params[:goal_id]
    goal_comment.save
    redirect_to goal_url(goal_comment.goal)
  end

  private
  def comment_params
    params.require(:goalcomment).permit(:body)
  end
end
