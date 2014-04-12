require 'spec_helper'

feature 'User Authentication' do
  scenario 'allows a user to signup' do
    @user = FactoryGirl.build(:user)
    visit '/'

    expect(page).to have_link('Signup')

    click_link 'Signup'

    fill_in 'First name', with: @user.first_name
    fill_in 'Last name', with: @user.last_name
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    fill_in 'Password confirmation', with: @user.password_confirmation

    click_button 'Signup'

    expect(current_path).to eq('/')
    expect(page).to have_text("Thank you for signing up #{@user.first_name}")
  end

  scenario 'login followed by signout' do
    @user = FactoryGirl.create(:user)
    visit '/'

    expect(page).to have_link('Login')

    click_link 'Login'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Login'

    click_link 'Logout'

    expect(page).to have_content("#{@user.email} has been logged out")
    expect(page).to have_link('Login')
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

  scenario 'does not allow to login with invalid credentials' do
    @user = FactoryGirl.build(:user)
    visit login_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Login'

    expect(page).to have_text("Invalid email or password")
    expect(page).to have_link('Login')
  end

end

feature "Profile Page" do
  scenario "allows to view user profile" do
    @user = FactoryGirl.create(:user)
    visit user_path(@user)

    expect(page).to have_content(@user.first_name)
    expect(page).to have_title("#{@user.first_name} #{@user.last_name}")
  end
end