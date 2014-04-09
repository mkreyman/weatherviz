class Location < ActiveRecord::Base
  has_many :weather_reports, :dependent => :destroy
end
