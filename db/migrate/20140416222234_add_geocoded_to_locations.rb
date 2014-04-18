class AddGeocodedToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :woeid, :integer
    add_column :locations, :street, :string
    add_column :locations, :state_code, :string
    add_column :locations, :postal_code, :string
    add_column :locations, :country_code, :string

    add_index :locations, [:latitude, :longitude]
  end
end
