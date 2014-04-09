class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :city_id
      t.string :city
      t.string :state
      t.string :country
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
