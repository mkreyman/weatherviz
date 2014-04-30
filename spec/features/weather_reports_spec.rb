require 'spec_helper'

feature 'Weather Reports Search', :vcr, record: :new_episodes do
  scenario 'Visitor views all recent reports', :vcr do
    visit '/weather_reports'

    expect(page).to have_content('Weather Reports')
    expect(page).to have_selector(:link_or_button, 'Search')
  end

  scenario 'Visitor searches for a location', :vcr do
    @location = create(:location)
    visit '/weather_reports'

    fill_in 'search', with: @location.city

    click_on 'Search'

    expect(page).to have_content(@location.city)
  end

  scenario 'Visitor searches for an invalid location', :vcr do
    @location = 'shshshgethr'
    visit '/weather_reports'

    fill_in 'search', with: @location

    click_on 'Search'

    expect(page).to have_content("Sorry, no results found.")
  end

  scenario 'Visitor views previously fetched reports', :vcr do
    @location = create(:location)
    visit '/locations'

    fill_in 'search', with: @location.city

    click_on 'Search'
    click_on('Show reports', match: :first)

    expect(page).to have_content(@location.city)
  end
end

feature "Deleting weather reports", :vcr do
  background do
    @location = create(:location)
    visit '/weather_reports'
    fill_in 'search', with: @location.city
    click_on 'Search'
  end

  scenario "visitor can't delete a report", :vcr do
    visit '/weather_reports'
    expect(page).to_not have_selector(:link_or_button, 'Delete')
  end

  scenario "Non-admin user can't delete a report", :vcr do
    @user = create(:user)
    sign_in(@user)

    visit '/weather_reports'
    expect(page).to_not have_selector(:link_or_button, 'Delete')
  end

  scenario "admin can delete a report", :vcr do
    @admin = create(:admin)
    sign_in(@admin)
    @location = 'Denver'
    visit '/weather_reports'

    fill_in 'search', with: @location
    click_on 'Search'

    expect(page).to have_selector(:link_or_button, 'Delete')

    click_on('Delete', match: :first)
    expect(page).to_not have_content(@location)
  end

end