require 'spec_helper'

feature 'User Authentication - signing up', :vcr do
  background do
    @user = build(:user)
  end

  scenario 'allows a user to signup', :vcr do
    ActionMailer::Base.deliveries.clear
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
    expect(page).to have_text("Signed in as #{@user.email}")

    expect(ActionMailer::Base.deliveries).to have(1).email
  end

  scenario "prevents signing up with blank password", :vcr do
    visit signup_path

    fill_in 'First name', with: @user.first_name
    fill_in 'Last name', with: @user.last_name
    fill_in 'Email', with: @user.email

    click_button 'Signup'
    expect(page).to have_content("Password can't be blank")
  end

  scenario "prevents signing up with the same email", :vcr do
    @user_existing = create(:user)

    visit signup_path

    fill_in 'First name', with: @user.first_name
    fill_in 'Last name', with: @user.last_name
    fill_in 'Email', with: @user_existing.email

    click_button 'Signup'
    expect(page).to have_content("Email has already been taken")
  end
end

feature 'User Authentication - signing in', :vcr do
  background do
    @user = create(:user)
  end

  scenario 'allows existing user to login', :vcr do
    visit '/'

    expect(page).to have_link('Login')

    click_link 'Login'

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password

    click_button 'Login'

    expect(page).to have_text("Welcome back #{@user.first_name}")
    expect(page).to have_text("Signed in as #{@user.email}")
  end

  scenario 'allows user to log out', :vcr do
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

  scenario 'prevents signing in with invalid credentials', :vcr do
    visit login_path

    fill_in 'Email', with: @user.email
    fill_in 'Password', with: ''

    click_button 'Login'

    expect(page).to have_text("Invalid email or password")
    expect(page).to have_link('Login')
  end
end


feature "Profile Page", :vcr do
  background do
    @user = create(:user)
    sign_in(@user)
  end

  scenario "allows signed in user to view their own profile", :vcr do
    visit user_path(@user)

    expect(page).to have_content(@user.first_name)
    expect(page).to have_title("#{@user.first_name} #{@user.last_name}")
  end

  scenario "allows signed in user to edit their profile", :vcr do
    visit edit_user_path(@user)

    expect(page).to have_content("Update your profile")
    expect(page).to have_title("Edit user")
    expect(page).to have_link('change', href: 'http://gravatar.com/emails')

    fill_in 'First name', with: "Joe"
    fill_in 'Last name', with: "Tester2"

    click_button 'Save changes'
    expect(page).to have_content('User was successfully updated.')
  end

  scenario "prevents user from updating their profile with blank or invalid email", :vcr do
    visit edit_user_path(@user)

    fill_in 'Email', with: ''

    click_button 'Save changes'
    expect(page).to have_content("Email can't be blank")
  end
end


feature 'User Authorization', :vcr do
  background do
    @admin = create(:admin)
    @user = create(:user)
  end

  scenario "prompts to login before visiting a protected page", :vcr do
    visit edit_user_path(@user)

    expect(page).to have_title("Log in")
    expect(current_path).to eq(login_path)
  end

  scenario "prevents user from viewing other users' profiles", :vcr do
    @another_user = create(:user)
    sign_in(@user)

    visit user_path(@another_user)
    expect(current_path).to eq(root_path)
    #save_and_open_page
    expect(page).to have_text("Not authorized")
  end

  scenario "allows admin to view all users", :vcr do
    sign_in(@admin)

    visit users_path

    expect(current_path).to eq(users_path)
    expect(page).to have_title("All users")
  end

  scenario "prevents non-admin user from viewing all users", :vcr do
    sign_in(@user)
    visit users_path

    expect(current_path).to eq(root_path)
    expect(page).to have_text("Not authorized")
  end

  scenario "allows admin to delete a user", :vcr do
    sign_in(@admin)
    visit users_path

    expect(page).to have_text('Delete')
    click_on('Delete', match: :first)

    expect(page).to have_content("User deleted.")
  end

  scenario "prevents non-admin from deleting themselves", :vcr do
    @another_user = create(:user)
    sign_in(@user)
    visit user_path(@user)

    expect(page).not_to have_text('Delete')
  end

  scenario "prevents admin from deleting themselves", :vcr do
    sign_in(@admin)
    visit users_path

    expect(page).to have_text('Delete')
    # for an existing user created as the 'background' for this feature.
    click_on('Delete', match: :first)

    expect(page).to have_content("User deleted.")

    # no more users except himself
    expect(page).not_to have_text('Delete')
  end

  scenario "prevents admin from disabling themselves as admin" do

  end

end


