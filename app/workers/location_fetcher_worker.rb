class LocationFetcherWorker
  @queue = :location_fetcher_worker

  def self.perform(search)
    LocationFetcher.fetch(search)
  end
end