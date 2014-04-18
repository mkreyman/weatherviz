require 'spec_helper'

feature 'Location Search' do
  scenario 'Visitor comes to homepage (with search box)' do
    visit root_path

    expect(page).to have_content('Search for a city name:')
  end

  scenario 'Visitor searches for a valid location' do
    #@location = create(:location)
    @location = 'Chicago'
    visit root_path

    fill_in 'Search for a city name:', with: @location

    click_button 'Search'

    expect(page).to have_content(@location)
  end

  # Found this doesn't work when deployed to Heroku.
  # Need to figure out how to do that method correctly,
  # so there would be no false negatives.
  #scenario 'Visitor searches for an invalid location' do
  #  @location = 'shshshgethr'
  #  visit root_path
  #
  #  fill_in 'Search for a city name:', with: @location
  #
  #  click_button 'Search'
  #
  #  expect(page).to have_content("Sorry, no results found.")
  #end

  scenario 'Visitor views previously fetched locations' do
    #@location = create(:location)
    @location = 'Boston'
    visit root_path

    fill_in 'Search for a city name:', with: @location

    click_button 'Search'

    visit '/locations'

    expect(page).to have_content("Listing locations")
    expect(page).to have_content(@location)
  end
end

feature "Deleting locations" do
  background do
    @location = 'New York'
    visit '/locations'
    fill_in 'Search for a city name:', with: @location
    click_button 'Search'
  end

  scenario "visitor can't delete a location" do
    visit '/locations'
    expect(page).to_not have_link('Delete')
  end

  scenario "visitor can't edit a location" do
    visit '/locations'
    expect(page).to_not have_link('Edit')
  end

  scenario "Non-admin user can't delete a locaton" do
    @user = create(:user)
    sign_in(@user)

    visit '/locations'
    expect(page).to_not have_link('Delete')
  end

  scenario "Non-admin user can't edit a locaton" do
    @user = create(:user)
    sign_in(@user)

    visit '/locations'
    expect(page).to_not have_link('Edit location')
  end

  scenario "admin can edit a location" do
    @admin = create(:admin)
    sign_in(@admin)

    visit '/locations'
    expect(page).to have_link('Edit location')

    click_link('Edit location', match: :first)

    expect(page).to have_button('Update Location')

    click_button('Update Location')

    expect(page).to have_text('Location was successfully updated.')
    expect(page).to have_content(@location)
  end

  scenario "admin can delete a location" do
    @admin = create(:admin)
    sign_in(@admin)

    visit '/locations'
    expect(page).to have_link('Delete')

    click_link('Delete', match: :first)
    expect(page).to have_text('Location was deleted.')
    expect(page).to_not have_content(@location)
  end
end
