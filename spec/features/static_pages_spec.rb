require 'spec_helper'

describe 'Static pages' do
  describe 'Home page' do

    it "should have the content 'WeatherViz'" do
      visit '/'
      expect(page).to have_content('WeatherViz')
    end

    it 'should have the WeatherViz logo' do
      visit '/'
      expect(page).to have_css("img[src$='weatherviz_logo.png']")
    end

    it "should link to the /signup" do
      visit '/'

      click_link 'Signup'

      expect(current_path).to eq('/signup')
    end

    it "should link to the /login" do
      visit '/'

      click_link 'Login'

      expect(current_path).to eq('/login')
    end

    it "should link to the /logout for logged in users" do
      @user = FactoryGirl.create(:user)
      visit '/'

      click_link 'Login'

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_button 'Login'

      expect(page).to have_link('Logout')
    end

    it "should have links to user specific pages for logged in users" do
      @user = FactoryGirl.create(:user)
      visit '/'

      click_link 'Login'

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_button 'Login'

      expect(page).to have_link('Profile')
      expect(page).to have_link('Settings')
      expect(page).to have_link('Alerts')
    end

    it "should hide links to user specific pages for visitors" do
      visit '/'

      expect(page).to_not have_link('Profile')
      expect(page).to_not have_link('Settings')
      expect(page).to_not have_link('Alerts')
    end

  end
end
