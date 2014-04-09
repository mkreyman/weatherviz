class CreateWeatherFetchers < ActiveRecord::Migration
  def change
    create_table :weather_fetchers do |t|
      t.text :data

      t.timestamps
    end
  end
end
