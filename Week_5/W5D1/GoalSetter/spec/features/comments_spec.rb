require 'spec_helper'
require 'rails_helper'
require 'support/auth_features_helper'
require 'support/goal_features_helper'

include AuthFeaturesHelper
include GoalFeaturesHelper

feature 'adding a comment to user profile' do
  scenario 'user profile has add comment form' do
    sign_up

    expect(page).to have_content "New Comment"
  end

end
