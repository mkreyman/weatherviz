require 'spec_helper'

feature 'Location Search' do
  scenario 'Visitor comes to homepage (with search box)' do
    visit root_path

    expect(page).to have_content('Search for a city name:')
  end

  scenario 'Visitor searches for a valid location', :vcr do
    @location = create(:location)
    visit root_path

    fill_in 'Search for a city name:', with: @location.city

    click_button 'Search'

    expect(page).to have_content(@location.city)
  end

  scenario 'Visitor searches for an invalid location', :vcr do
    @location = 'shshshgethr'
    visit root_path

    fill_in 'Search for a city name:', with: @location

    click_button 'Search'

    expect(page).to have_content("Sorry, no results found.")
  end

  scenario 'Visitor views previously fetched locations', :vcr do
    @location = create(:location)
    visit root_path

    fill_in 'Search for a city name:', with: @location.city

    click_button 'Search'

    visit '/locations'

    expect(page).to have_content("Listing locations")
    expect(page).to have_content(@location.city)
  end
end

feature "Deleting locations", :vcr do
  background do
    @location = create(:location)
    visit '/locations'
    fill_in 'Search for a city name:', with: @location.city
    click_button 'Search'
  end

  scenario "visitor can't delete a location", :vcr do
    visit '/locations'
    expect(page).to_not have_link('Delete')
  end

  scenario "visitor can't edit a location", :vcr do
    visit '/locations'
    expect(page).to_not have_link('Edit')
  end

  scenario "Non-admin user can't delete a location", :vcr do
    @user = create(:user)
    sign_in(@user)

    visit '/locations'
    expect(page).to_not have_link('Delete')
  end

  scenario "Non-admin user can't edit a location", :vcr do
    @user = create(:user)
    sign_in(@user)

    visit '/locations'
    expect(page).to_not have_link('Edit location')
  end

  scenario "admin can edit a location", :vcr do
    @admin = create(:admin)
    sign_in(@admin)

    visit '/locations'
    expect(page).to have_link('Edit location')

    click_link('Edit location', match: :first)

    expect(page).to have_button('Update Location')

    click_button('Update Location')

    expect(page).to have_text('Location was successfully updated.')
    expect(page).to have_content(@location.city)
  end

  scenario "admin can delete a location", :vcr do
    @location = 'Denver'
    @admin = create(:admin)
    sign_in(@admin)

    visit '/locations'
    fill_in 'Search for a city name:', with: @location
    click_button 'Search'

    expect(page).to have_link('Delete')

    click_link('Delete', match: :first)
    expect(page).to have_text('Location was deleted.')
    expect(page).to_not have_content(@location)
  end
end

feature "Homepage displays visitor specific information", :vcr do
  background do
    @location = create(:location)
    visit '/'
  end
  scenario "should display a location map", :vcr do

    expect(page).to have_css("img[src$='#{@location.longitude}']")
  end

  scenario "should display a link to weather report for that location", :vcr do

    expect(page).to have_link('View Weather Reports for this location')
    click_link 'View Weather Reports for this location'

    expect(page).to have_content("Listing reports for #{@location.city}")
  end
end