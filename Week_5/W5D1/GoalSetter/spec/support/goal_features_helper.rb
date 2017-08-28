module GoalFeaturesHelper
  def add_goal
    visit new_goal_url
    fill_in 'Title', with: 'Pass Auth Test'
    fill_in 'Details', with: 'Really need to pass'
    click_button 'Add Goal'
  end
end
