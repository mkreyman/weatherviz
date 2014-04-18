require 'open-uri'
require 'json'

class LocationFetcher
  def self.fetch(search, provider='openweather')

    # API key for OpenWeatherMap API
    appkey = "APPID=#{ENV['OPENWEATHER_APPID']}"

    @city_id = nil
    @city = nil
    @state_code = nil
    @state = nil
    @country_code = nil
    @country = nil
    @latitude = nil
    @longitude = nil

    if provider == 'openweather'
      city_and_state_url = "http://api.openweathermap.org/data/2.5/weather?q="
      sanitized_search = search.split(', ').join(',').downcase
      url = URI.escape("#{city_and_state_url}#{sanitized_search}&#{appkey}")
      response = JSON.parse(open(url).read)
      @city_id = response['id']
      @city = response['name']
      if (response['sys']['country'] == 'United States of America')
        @country = 'USA'
        @country_code = 'US'
      else
        @country = response['sys']['country']
        @country_code = @country
      end
      @latitude = response['coord']['lat']
      @longitude = response['coord']['lon']

    elsif provider == 'geocoder'
      @geo = Geocoder.search(search).first
      @city = geo.data['address_components'][0]['long_name']
      @state_code = geo.data['address_components'][2]['short_name']
      @country_code = geo.data['address_components'][3]['short_name']
      @latitude = geo.data["geometry"]["location"]["lat"]
      @longitude = geo.data["geometry"]["location"]["lng"]

    else
      @city = 'Denver'
      @state_code = 'CO'
      @state = 'Colorado'
      @country_code = 'US'
      @country = "United States"
    end

    @location = Location.where(
      city: @city,
      state_code: @state_code,
      country_code: @country_code).first_or_create do |location|
        location.city_id = @city_id
        location.city = @city
        location.state_code = @state_code
        location.state = @state
        location.country_code = @country_code
        location.country = @country
        location.latitude = @latitude
        location.longitude = @longitude
      end
  end
end