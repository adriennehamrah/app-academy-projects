require 'spec_helper'
require 'rails_helper'
require 'support/auth_features_helper'
require 'support/goal_features_helper'
require 'support/comment_features_helper'

include AuthFeaturesHelper
include GoalFeaturesHelper
include CommentFeaturesHelper

feature 'adding a comment to user profile' do
  scenario 'user profile has add comment form' do
    sign_up
    expect(page).to have_content "New Comment"
  end

  scenario 'added comment shows up on user profile' do
    sign_up
    add_user_comment
    expect(page).to have_content 'I like your profile'
  end
end

feature 'adding a comment to goal page' do
  scenario 'goal page has add comment form' do
    sign_up
    add_goal
    expect(page).to have_content "New Comment"
  end

  scenario 'added comment shows up on goal age' do
    sign_up
    add_goal
    add_goal_comment
    expect(page).to have_content 'Great goal'
  end
end
