require 'open-uri'
require 'json'

class LocationFetcher

  def self.fetch(search, provider='geocoder')
    location_response = if provider == 'openweather'
                          self.search_by_openweather(search)
                        elsif provider == 'geocoder'
                          self.search_by_geocoder(search)
                        end
    if location_response.empty?
      location_response = { city: 'Denver', state_code: 'CO',
                            state: 'Colorado', country_code: 'US', country: 'USA',
                            latitude: 39.7392, longitude: -104.9847 }
    end
    location_search_params = {city: location_response[:city],
                              country_code: location_response[:country_code]}
    if location_response[:state_code].present?
      location_search_params.merge!(state_code: location_response[:state_code])
    end
    @location = Location.where(location_search_params).first_or_create do |location|
      location.city_id      = location_response[:city_id]
      location.state_code   = location_response[:state_code],
      location.city         = location_response[:city]
      location.state_code   = location_response[:state_code]
      location.state        = location_response[:state]
      location.country_code = location_response[:country_code]
      location.country      = location_response[:country]
      location.latitude     = location_response[:latitude]
      location.longitude    = location_response[:longitude]
    end
  end

  def self.search_by_openweather(search)
    # API key for OpenWeatherMap API
    appkey = "APPID=#{ENV['OPENWEATHER_APPID']}"

    city_and_state_url = "http://api.openweathermap.org/data/2.5/weather?q="
    url = URI.escape("#{city_and_state_url}#{search}&#{appkey}")
    response = JSON.parse(open(url).read)
    if response['cod'] == '404'
      {}
    else
      city_id = response['id']
      city = response['name']
      if (response['sys']['country'] == 'United States of America')
        country = 'USA'
        country_code = 'US'
      else
        country = response['sys']['country']
        country_code = country
      end
      latitude = response['coord']['lat']
      longitude = response['coord']['lon']
      { city_id: city_id, city: city, country: country,
        country_code: country_code, latitude: latitude, longitude: longitude }
    end
  end

  def self.search_by_geocoder(search)
    results = Geocoder.search(search)

    if geo = results.first
      {
          city: geo.city,
          state_code: geo.state_code,
          country_code: geo.country_code,
          latitude: geo.latitude,
          longitude: geo.longitude
      }
    else
      {}
    end
  end
end