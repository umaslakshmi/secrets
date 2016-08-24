require 'rails_helper'
feature 'logging in' do
  before do
    @user = create_user
  end
  scenario 'prompts for email and password' do
    visit '/sessions/new'
    # puts page.body
    expect(page).to have_field("email")
    expect(page).to have_field('password')
  end
  scenario 'logs in user if email/password combination is valid' do
    log_in @user
    expect(current_path).to eq("/users/#{@user.id}")
    expect(page).to have_text(@user.name)
  end
  scenario 'does not sign in user if email/password combination is invalid' do
    log_in @user, 'wrong password'
    expect(page).to have_text('Invalid')
  end
end