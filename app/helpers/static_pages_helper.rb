module StaticPagesHelper
  @location = Location.new

  def visitor_location
    if Rails.env.test? || Rails.env.development?
      @response = Geocoder.search('174.51.246.225').first
    else
      @response ||= request.location
    end
    @location = Location.where(city: @response.city,
                               state_code: @response.state_code)
    .first_or_create do |location|
      location.city = @response.city
      location.state_code = @response.state_code
      location.latitude = @response.latitude
      location.longitude = @response.longitude
    end
  end
end