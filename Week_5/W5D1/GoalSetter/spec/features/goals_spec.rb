require 'spec_helper'
require 'rails_helper'
require 'support/auth_features_helper'
require 'support/goal_features_helper'

include AuthFeaturesHelper
include GoalFeaturesHelper

feature 'adding a new goal' do
  scenario 'has a new goal page' do
    visit new_goal_url
    expect(page).to have_content "New Goal"
  end

  scenario 'shows goal title on goal page after adding goal' do
    sign_up
    add_goal

    expect(page).to have_content "Pass Auth Test"
  end
end

feature 'marking goal completed' do
  scenario 'has a button on goal page to complete goal' do
    sign_up
    add_goal
    expect(page).to have_content "Complete Goal"
  end

  scenario 'clicking complete goal marks goal as complete on goal page' do
    sign_up
    add_goal
    click_button 'Complete Goal'

    expect(page).to have_content 'completed'
  end

  scenario 'clicking complete goal marks goal as complete on user page' do
    sign_up
    add_goal
    click_button 'Complete Goal'
    click_on 'User Profile'

    expect(page).to have_content 'completed'
  end
end
