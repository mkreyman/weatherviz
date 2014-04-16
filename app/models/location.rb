class Location < ActiveRecord::Base
  has_many :weather_reports, :dependent => :destroy
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude do |location,results|
    if geo = results.first
      location.street       = geo.address
      location.city         = geo.city
      location.state_code   = geo.state_code
      location.state        = geo.state
      location.postal_code  = geo.postal_code
      location.country_code = geo.country_code
      location.country      = geo.country
      location.latitude     = geo.latitude
      location.longitude    = geo.longitude
    end
  end
  after_validation :geocode

  def self.search(search)
    if search
      where("city LIKE ?", "%#{search}%")
    else
      Location.all
    end
  end

  def address
    [:street, :city, :state, :country].compact.join(', ')
  end

  def coordinates
    [:latitude, :longitude]
  end
end
