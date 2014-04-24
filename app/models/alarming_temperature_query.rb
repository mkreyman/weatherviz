class AlarmingTemperatureQuery

  #def initialize(location)
  #  @latest_report = location.weather_reports.order(time_received: :desc).limit(1)
  #end
  #
  #def above(upper_limit)
  #  @latest_report.where("temp > ?", upper_limit)
  #end
  #
  #def below(lower_limit)
  #  @latest_report.where("temp < ?", lower_limit)
  #end

  def initialize(locations = Location.joins(:weather_reports))
    time_range = (Time.now - 1.day).to_i..Time.now.to_i
    @locations = locations.where(weather_reports: { time_received: time_range })
  end

  def above(upper_limit)
    @locations.where(weather_reports: { temp: upper_limit..330 })
  end

  def below(lower_limit)
    @locations.where(weather_reports: { temp: 184..lower_limit })
  end

end