module AuthFeaturesHelper
  def sign_up
    visit new_user_url
    fill_in 'Username', with: "firstuser"
    fill_in 'Password', with: "123456"
    click_button 'Sign Up!'
  end

  def login
    visit new_session_url
    fill_in 'Username', with: "firstuser"
    fill_in 'Password', with: "123456"
    click_button 'Log In!'
  end
end
