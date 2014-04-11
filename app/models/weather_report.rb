class WeatherReport < ActiveRecord::Base
  belongs_to :location, :autosave => true

  def self.search(search)
    if search
      WeatherReport.joins(:location).where("city LIKE ?", "%#{search}%")
    else
      WeatherReport.all
    end
  end
end
