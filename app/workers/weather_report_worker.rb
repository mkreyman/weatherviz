class WeatherReportWorker
  @queue = :weather_report_worker

  def self.perform
    Location.where(id: Alert.select("distinct(location_id)")
                       .map(&:location_id)).each do |location|
      weather_report = WeatherFetcher.fetch(location)
      location.alerts.map do |alert|
        AlertNotification.new.send_alert(alert, weather_report)
      end
    end
  end
end