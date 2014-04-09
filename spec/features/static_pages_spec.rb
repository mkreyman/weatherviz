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

      expect(current_path).to eq('/users/new')
    end

    it "should link to the /login" do
      visit '/'

      click_link 'Login'

      expect(current_path).to eq('/login')
    end

  end
end
