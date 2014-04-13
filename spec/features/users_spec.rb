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

  scenario "prevents signing up with blank password" do
    @user = FactoryGirl.build(:user)
    visit signup_path

    fill_in 'First name', with: @user.first_name
    fill_in 'Last name', with: @user.last_name
    fill_in 'Email', with: @user.email

    click_button 'Signup'
    expect(page).to have_content("Password can't be blank")
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
  scenario "allows signed in user to view their own profile" do
    @user = FactoryGirl.create(:user)
    sign_in(@user)

    visit user_path(@user)

    expect(page).to have_content(@user.first_name)
    expect(page).to have_title("#{@user.first_name} #{@user.last_name}")
  end

  scenario "allows signed in user to edit user profile" do
    @user = FactoryGirl.create(:user)
    sign_in(@user)

    visit edit_user_path(@user)

    expect(page).to have_content("Update your profile")
    expect(page).to have_title("Edit user")
    expect(page).to have_link('change', href: 'http://gravatar.com/emails')

    fill_in 'First name', with: "Joe"
    fill_in 'Last name', with: "Tester2"

    click_button 'Save changes'
    expect(page).to have_content('User was successfully updated.')
  end

  scenario "prevents user from updating their profile with blank or invalid email" do
    @user = FactoryGirl.create(:user)
    sign_in(@user)

    visit edit_user_path(@user)

    fill_in 'Email', with: ''

    click_button 'Save changes'
    expect(page).to have_content('errors')
  end
end

feature "Authentication" do
  scenario "prompts non-signed-in users to login when attempting to visit a protected page" do
    @user = FactoryGirl.create(:user)
    visit edit_user_path(@user)

    expect(page).to have_title("Log in")
    expect(current_path).to eq(login_path)
  end


end
