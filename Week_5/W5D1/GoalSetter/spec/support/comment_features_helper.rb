module CommentFeaturesHelper
  def add_user_comment
    fill_in 'Comment', with: 'I like your profile'
    click_on 'Save Comment'
  end

  def add_goal_comment
    fill_in 'Comment', with: 'Great goal'
    click_on 'Save Comment'
  end
end
