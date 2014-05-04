class WeatherReport < ActiveRecord::Base
  belongs_to :location, touch: true, autosave: true

  def self.per_page
    10
  end

  def self.search(search)
    if search
      WeatherReport.joins(:location).where("city LIKE ?", "%#{search}%")
    else
      WeatherReport.all
    end
  end

  def city
    Location.find(self.location_id).city
  end
end
