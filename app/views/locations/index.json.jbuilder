json.array!(@locations) do |location|
  json.extract! location, :id, :city_id, :city, :state, :country, :lat, :lon
  json.url location_url(location, format: :json)
end
