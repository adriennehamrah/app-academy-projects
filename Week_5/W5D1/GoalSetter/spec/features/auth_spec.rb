require 'spec_helper'
require 'rails_helper'
require 'support/auth_features_helper'

include AuthFeaturesHelper

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Sign Up'
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      sign_up
      expect(page).to have_content 'firstuser'
    end
  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    sign_up
    login
    expect(page).to have_content 'firstuser'
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit users_url
    expect(page).to_not have_content 'Log Out'
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    sign_up
    login

    click_button 'Sign Out'

    expect(page).to_not have_content 'firstuser'
  end

end
