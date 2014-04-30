require 'spec_helper'

feature 'Location Search' do
  scenario 'Visitor comes to homepage (with search box)' do
    visit root_path

    expect(page).to have_button('Search')
  end

  scenario 'Visitor searches for a valid location', :vcr do
    @location = create(:location)
    visit root_path

    fill_in 'search', with: @location.city

    click_button 'Search'

    expect(page).to have_content(@location.city)
    expect(page).to_not have_content("Sorry, no results found.")
  end

  scenario 'Visitor searches for an invalid location', :vcr do
    @location = 'shshshgethr'
    visit root_path

    fill_in 'search', with: @location

    click_button 'Search'

    expect(page).to have_content("Sorry, no results found.")
  end

  scenario 'Visitor views previously fetched locations', :vcr do
    @location = create(:location)
    visit root_path

    fill_in 'search', with: @location.city

    click_button 'Search'

    visit '/locations'

    expect(page).to have_content("Locations")
    expect(page).to have_content(@location.city)
  end
end

feature "Deleting locations", :vcr do
  background do
    @location = create(:location)
    visit '/locations'
    fill_in 'search', with: @location.city
    click_button 'Search'
  end

  scenario "visitor can't delete a location", :vcr do
    visit '/locations'
    expect(page).to_not have_selector(:link_or_button, 'Delete')
  end

  scenario "visitor can't edit a location", :vcr do
    visit '/locations'
    expect(page).to_not have_selector(:link_or_button, 'Edit')
  end

  scenario "Non-admin user can't delete a location", :vcr do
    @user = create(:user)
    sign_in(@user)

    visit '/locations'
    expect(page).to_not have_selector(:link_or_button, 'Delete')
  end

  scenario "Non-admin user can't edit a location", :vcr do
    @user = create(:user)
    sign_in(@user)

    visit '/locations'
    expect(page).to_not have_selector(:link_or_button, 'Edit')
  end

  scenario "admin can edit a location", :vcr do
    @admin = create(:admin)
    sign_in(@admin)

    visit '/locations'
    expect(page).to have_selector(:link_or_button, 'Edit')

    click_on('Edit', match: :first)

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
    fill_in 'search', with: @location
    click_button 'Search'

    expect(page).to have_selector(:link_or_button, 'Delete')

    click_on('Delete', match: :first)
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

  scenario "should display a button to weather report for that location", :vcr do

    expect(page).to have_selector(:link_or_button, 'View Weather Reports')
    click_on 'View Weather Reports'

    expect(page).to have_content("Listing reports for #{@location.city}")
  end
end