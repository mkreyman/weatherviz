require 'open-uri'
require 'json'

class Location < ActiveRecord::Base
  has_many :weather_reports, :dependent => :destroy

  before_save :parse_json

  def parse_json

  end
end
