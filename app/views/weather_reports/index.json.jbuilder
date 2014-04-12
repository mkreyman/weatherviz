json.array!(@weather_reports) do |weather_report|
  json.extract! weather_report, :id, :time_received, :sunrise, :sunset, :weather, :weather_desc, :temp, :temp_min, :temp_max, :pressure, :humidity, :wind_speed, :wind_gust, :wind_degree, :clouds, :rain_3h, :snow_3h
  json.url weather_report_url(weather_report, format: :json)
end
