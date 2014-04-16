class RenameColumnsInLocations < ActiveRecord::Migration
  def change
    rename_column :locations, :lat, :latitude
    rename_column :locations, :lon, :longitude
  end
end
