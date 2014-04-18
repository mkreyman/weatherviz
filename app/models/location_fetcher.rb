class LocationFetcher
  def self.fetch(search)

    geo = Geocoder.search(search).first
    city = geo.data['address_components'][0]['long_name']
    state_code = geo.data['address_components'][2]['short_name']
    country_code = geo.data['address_components'][3]['short_name']
    latitude = geo.data["geometry"]["location"]["lat"]
    longitude = geo.data["geometry"]["location"]["lng"]

    @location = Location.where(
      city: city,
      state_code: state_code,
      country_code: country_code).first_or_create do |location|
        location.city = city
        location.state_code = state_code
        location.country_code = country_code
        location.latitude = latitude
        location.longitude = longitude
      end
  end
end