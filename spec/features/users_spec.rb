require 'spec_helper'

feature 'User Authentication' do
  scenario 'allows a user to signup' do
    visit '/'

    expect(page).to have_link('Signup')

    click_link 'Signup'

    fill_in 'First name', with: 'Kaitlin'
    fill_in 'Last name', with: 'Barrer'
    fill_in 'Email', with: 'kaitlin@barrer.com'
    fill_in 'Password', with: 'supersecret'
    fill_in 'Password confirmation', with: 'supersecret'

    click_button 'Signup'

    expect(current_path).to eq('/')
    expect(page).to have_text('Thank you for signing up Kaitlin')
  end

  scenario 'allows existing user to login' do
    @user = FactoryGirl.create(:user)
    visit '/'

    expect(page).to have_link('Login')

    click_link 'Login'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Login'

    expect(page).to have_text("Welcome back #{@user.first_name}")
    expect(page).to have_text("Signed in as #{@user.email}")
  end


end