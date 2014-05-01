class WeatherFetcherWorker
  @queue = :weather_fetcher_worker

  def self.perform(location)
    WeatherFetcher.fetch(location)
  end
end