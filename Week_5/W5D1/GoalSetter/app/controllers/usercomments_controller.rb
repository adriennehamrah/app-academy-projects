class UsercommentsController < ApplicationController
  def create
    user_comment = Usercomment.new(comment_params)
    user_comment.user_id = params[:user_id]
    user_comment.save
    redirect_to user_url(user_comment.user)
  end

  private
  def comment_params
    params.require(:usercomment).permit(:body)
  end
end
