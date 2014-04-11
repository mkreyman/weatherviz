class Location < ActiveRecord::Base
  has_many :weather_reports, :dependent => :destroy

  def self.search(search)
    if search
      where("city LIKE ?", "%#{search}%")
    else
      Location.all
    end
  end
end
