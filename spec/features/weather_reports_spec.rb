require 'spec_helper'

feature 'Weather Reports Search' do
  scenario 'Visitor views all recent reports' do
    visit '/weather_reports'

    expect(page).to have_content('Recent weather reports')
    expect(page).to have_content('Search for a city name:')
  end

  scenario 'Visitor searches for a location' do
    # @location = FactoryGirl.create(:location)
    # Faker gives too hard to find cities!
    @location = 'Boulder'
    visit '/weather_reports'

    fill_in 'Search for a city name:', with: @location

    click_button 'Search'

    expect(page).to have_content(@location)
  end

  scenario 'Visitor searches for an invalid location' do
    @location = 'shshshgethr'
    visit '/weather_reports'

    fill_in 'Search for a city name:', with: @location

    click_button 'Search'

    expect(page).to have_content("Sorry, no results found.")
  end

  scenario 'Visitor views previously fetched reports' do
    # @location = FactoryGirl.create(:location)
    # Faker gives too hard to find cities!
    @location = 'Denver'
    visit '/weather_reports'

    fill_in 'Search for a city name:', with: @location

    click_button 'Search'

    click_on 'Show'

    expect(page).to have_content(@location)
  end

end