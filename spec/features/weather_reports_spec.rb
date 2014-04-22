require 'spec_helper'

feature 'Weather Reports Search', :vcr do
  scenario 'Visitor views all recent reports', :vcr do
    visit '/weather_reports'

    expect(page).to have_content('Recent weather reports')
    expect(page).to have_content('Search for a city name:')
  end

  scenario 'Visitor searches for a location', :vcr do
    @location = create(:location)
    visit '/weather_reports'

    fill_in 'Search for a city name:', with: @location.city

    click_button 'Search'

    expect(page).to have_content(@location.city)
  end

  scenario 'Visitor searches for an invalid location', :vcr do
    @location = 'shshshgethr'
    visit '/weather_reports'

    fill_in 'Search for a city name:', with: @location

    click_button 'Search'

    expect(page).to have_content("Sorry, no results found.")
  end

  scenario 'Visitor views previously fetched reports', :vcr do
    @location = create(:location)
    visit '/locations'

    fill_in 'Search for a city name:', with: @location.city

    click_button 'Search'
    click_link('Show reports', match: :first)

    expect(page).to have_content(@location.city)
  end
end

feature "Deleting weather reports", :vcr do
  background do
    @location = create(:location)
    visit '/weather_reports'
    fill_in 'Search for a city name:', with: @location.city
    click_button 'Search'
  end

  scenario "visitor can't delete a report", :vcr do
    visit '/weather_reports'
    expect(page).to_not have_link('Delete')
  end

  scenario "Non-admin user can't delete a report", :vcr do
    @user = create(:user)
    sign_in(@user)

    visit '/weather_reports'
    expect(page).to_not have_link('Delete')
  end

  scenario "admin can delete a report", :vcr do
    @admin = create(:admin)
    sign_in(@admin)
    @location = 'Denver'
    visit '/weather_reports'

    fill_in 'Search for a city name:', with: @location
    click_button 'Search'

    expect(page).to have_link('Delete')

    click_link('Delete', match: :first)
    expect(page).to_not have_content(@location)
  end

end