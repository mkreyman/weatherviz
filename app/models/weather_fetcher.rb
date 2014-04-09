require 'open-uri'
require 'json'

class WeatherFetcher < ActiveRecord::Base
  serialize :data, Hash

  # API key for OpenWeatherMap API
  APPKEY = "APPID=#{ENV['OPENWEATHER_APPID']}"

  def self.fetch(location)
    search_by_city_url = "http://api.openweathermap.org/data/2.5/find?q="
    url = URI.escape("#{search_by_city_url}#{location}&#{APPKEY}")
    array_of_responses = JSON.parse(open(url).read)

    array_of_responses['list'].each do |response|

      if existing_city = Location.where(city_id: response['id']).first
        @location = existing_city
      else
        @location = Location.new
        @location.city_id = response['id']
        @location.city = response['name']
        @location.country = response['sys']['country']
        @location.lat = response['coord']['lat']
        @location.lon = response['coord']['lon']
        @location.save
      end

      weather_report = WeatherReport.new(location: @location)
      weather_report.time_received = response['dt']
      weather_report.sunrise = response['sys']['sunrise']
      weather_report.sunset = response['sys']['sunset']
      weather_report.weather = response['weather'].first['main']
      weather_report.weather_desc = response['weather'].first['description']
      weather_report.temp = response['main']['temp']
      weather_report.temp_min = response['main']['temp_min']
      weather_report.temp_max = response['main']['temp_max']
      weather_report.pressure = response['main']['pressure']
      weather_report.humidity = response['main']['humidity']
      weather_report.wind_speed = response['wind']['speed']
      weather_report.wind_gust = response['wind']['gust']
      weather_report.wind_degree = response['wind']['deg']
      weather_report.clouds = response['clouds']['all']
      weather_report.rain_3h = response['rain']['3h'] unless response['rain'].nil?
      weather_report.snow_3h = response['snow']['3h'] unless response['snow'].nil?
      weather_report.save

    end
  end
end
