class CreateWeatherReports < ActiveRecord::Migration
  def change
    create_table :weather_reports do |t|
      t.integer :time_received
      t.integer :sunrise
      t.integer :sunset
      t.string :weather
      t.string :weather_desc
      t.float :temp
      t.float :temp_min
      t.float :temp_max
      t.integer :pressure
      t.integer :humidity
      t.float :wind_speed
      t.float :wind_gust
      t.integer :wind_degree
      t.string :clouds
      t.integer :rain_3h
      t.integer :snow_3h
      t.references :location, index: true

      t.timestamps
    end
  end
end
