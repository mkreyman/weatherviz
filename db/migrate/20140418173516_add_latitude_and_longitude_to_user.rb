class AddLatitudeAndLongitudeToUser < ActiveRecord::Migration
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :ip_address, :string

    add_index :users, [:latitude, :longitude]
  end
end
