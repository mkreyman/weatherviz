require 'spec_helper'

feature 'Location Search' do
  scenario 'Visitor comes to homepage (with search box)' do
    visit root_path

    expect(page).to have_content('Search for a city name:')
  end

  scenario 'Visitor searches for a valid location' do
    @location = FactoryGirl.create(:location)
    visit root_path

    fill_in 'Search for a city name:', with: @location.city

    click_button 'Search'

    expect(page).to have_content(@location.city)
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
    @location = FactoryGirl.create(:location)
    visit root_path

    fill_in 'Search for a city name:', with: @location.city

    click_button 'Search'

    visit '/locations'

    expect(page).to have_content("Listing locations")
    expect(page).to have_content(@location.city)
  end

end