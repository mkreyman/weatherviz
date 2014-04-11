module WeatherReportsHelper

  def time_received(weather_report)
    if Time.at(weather_report.time_received).today?
      Time.at(weather_report.time_received).strftime("today at %I:%M %P")
    else
      Time.at(weather_report.time_received).strftime("%x, %I:%M %P")
    end
  end

  def city(weather_report)
    if weather_report.location['country'] == 'United States of America'
      weather_report.location['city'] + ' (US)'
    else
      weather_report.location['city'] + ' (' + weather_report.location['country'] + ')'
    end
  end

  def describe_weather(weather_report)
    if weather_report.weather.downcase == weather_report.weather_desc.downcase
      weather_report.weather
    elsif
    weather_report.weather_desc.downcase.split(' ').include? weather_report.weather.downcase
      weather_report.weather_desc.capitalize
    else
      "#{weather_report.weather}: #{weather_report.weather_desc}"
    end
  end

  def sunrise(weather_report)
    weather_report.sunrise || 'n/a'
  end

  def sunset(weather_report)
    weather_report.sunset || 'n/a'
  end

  def temp(weather_report)
    to_F(weather_report.temp).to_i.to_s + ' F'
  end

  def temp_min(weather_report)
    to_F(weather_report.temp_min).to_i.to_s + ' F'
  end

  def temp_max(weather_report)
    to_F(weather_report.temp_max).to_i.to_s + ' F'
  end

  def pressure(weather_report)
    hPA_to_psi(weather_report.pressure).to_i.to_s + ' psi'
  end

  def humidity(weather_report)
    weather_report.humidity.to_s + '%'
  end

  def wind_speed(weather_report)
    mps_to_mph(weather_report.wind_speed).to_i.to_s + ' mph'
  end

  def wind_gust(weather_report)
    if weather_report.wind_gust
      mps_to_mph(weather_report.wind_gust).to_i.to_s + ' mph'
    else
      'n/a'
    end
  end

  def wind_degree(weather_report)
    azimuth_to_cardinal(weather_report.wind_degree)
    #weather_report.wind_degree
  end

  def clouds(weather_report)
    weather_report.clouds.to_s + '%'
  end

  def rain_3h(weather_report)
    if weather_report.rain_3h
      sprintf("%.02f", mm_to_inch(weather_report.rain_3h))
    else
      'n/a'
    end
  end

  def snow_3h(weather_report)
    if weather_report.snow_3h
      sprintf("%.02f", mm_to_inch(weather_report.snow_3h))
    else
      'n/a'
    end
  end

  def to_F(kelvin)
    kelvin * 9 / 5 - 459.67
  end

  def hPA_to_psi(pressure)
    pressure / 68.95
  end

  def mps_to_mph(speed)
    speed * 2.237
  end

  def azimuth_to_cardinal(degree)
    # N = 0 or 360 degrees, E = 90 degrees, S = 180 degrees & W=270 degrees
    # NE = 45 degrees, SE = 135 degrees, SW = 225 degrees & NW = 315 degrees
    case
      when degree.between?(0, 22) || degree.between?(337, 360) then 'N'
      when degree.between?(23, 67) then 'NE'
      when degree.between?(68, 112) then 'E'
      when degree.between?(113, 157) then 'SE'
      when degree.between?(158, 202) then 'S'
      when degree.between?(203, 247) then 'SW'
      when degree.between?(248, 292) then 'W'
      when degree.between?(293, 336) then 'NW'
    end
  end

  def mm_to_inch(precipitation)
    precipitation * 0.0393701
  end

end
