require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content 'Sign Up'
  end

  feature 'signing up a user' do
    before(:each) do
      visit new_user_url
      fill_in 'Username', with: "firstuser"
      fill_in 'Password', with: "123456"
      click_on 'Sign Up!'
    end

    scenario 'shows username on the homepage after signup' do
      expect(page).to have_content 'firstuser'
    end
  end
end

feature 'logging in' do
  before(:each) do
    visit new_user_url
    fill_in 'Username', with: "firstuser"
    fill_in 'Password', with: "123456"
    click_button 'Sign Up!'

    visit new_session_url
    fill_in 'Username', with: "firstuser"
    fill_in 'Password', with: "123456"
    click_button 'Log In!'
  end
  scenario 'shows username on the homepage after login' do
    expect(page).to have_content 'firstuser'
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit users_url
    expect(page).to_not have_content 'Log Out'
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    visit new_user_url
    fill_in 'Username', with: "firstuser"
    fill_in 'Password', with: "123456"
    click_button 'Sign Up!'

    visit new_session_url
    fill_in 'Username', with: "firstuser"
    fill_in 'Password', with: "123456"
    click_button 'Log In!'

    click_button 'Sign Out'

    expect(page).to_not have_content 'firstuser'
  end

end
