class WeatherReport < ActiveRecord::Base
  belongs_to :location, :autosave => true
end
