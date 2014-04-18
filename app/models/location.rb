class Location < ActiveRecord::Base
  has_many :weather_reports, :dependent => :destroy
  geocoded_by :city do |obj,results|
    if geo = results.first
      obj.street = geo.address.split(', ').first
      obj.city    = geo.city
      obj.state_code = geo.state_code
      obj.postal_code = geo.postal_code
      obj.state = geo.state
      obj.country_code = geo.country_code
      obj.country = geo.country
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    end
  end
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.street = geo.address.split(', ').first
      obj.city    = geo.city
      obj.state_code = geo.state_code
      obj.postal_code = geo.postal_code
      obj.state = geo.state
      obj.country_code = geo.country_code
      obj.country = geo.country
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
    end
  end
  #after_validation :geocode
  after_validation :reverse_geocode, :if => :city_id_changed?


  def self.search(search)
    if search
      where("city LIKE ?", "%#{search}%")
    else
      Location.all
    end
  end

  def address
    [self.street, self.city, self.state_code, self.country_code].compact.join(', ')
  end

  def coordinates
    [self.latitude, self.longitude]
  end

end
