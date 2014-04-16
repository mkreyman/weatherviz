require 'open-uri'
require 'json'

class WeatherFetcher

  @fetched_data = {}

  # API key for OpenWeatherMap API
  APPKEY = "APPID=#{ENV['OPENWEATHER_APPID']}"

  def self.fetch(location)

    sanitized_location = location.split(/[\s,]+/).map(&:strip).join(',')

    #if @fetched_data[sanitized_location] &&  @fetched_data[sanitized_location]['cached_at'] > 10.minutes.ago
    #  @fetched_data[sanitized_location] = nil
    #end

    if @fetched_data[sanitized_location]
      if @fetched_data[sanitized_location]['cached_at'] > 10.minutes.ago
        @fetched_data[sanitized_location] = nil
      else
        return @fetched_data[sanitized_location]
      end
    end

    search_by_city_url = "http://api.openweathermap.org/data/2.5/find?q="
    url = URI.escape("#{search_by_city_url}#{sanitized_location}&#{APPKEY}")
    @fetched_data[sanitized_location] ||= JSON.parse(open(url).read).merge('cached_at' => Time.now)

    @fetched_data[sanitized_location]['list'].each do |response|

      @location = Location.where(
          city_id: response['id']).first_or_create do |location|

        location.city_id = response['id']
        location.city = response['name']
        location.country = response['sys']['country']
        location.latitude = response['coord']['lat']
        location.longitude = response['coord']['lon']
      end

      weather_report = WeatherReport.where(location: @location,
        time_received: response['dt']).first_or_create do |weather_report|

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
      end
    end
  end
end
