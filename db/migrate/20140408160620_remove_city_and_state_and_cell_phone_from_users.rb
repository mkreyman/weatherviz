class RemoveCityAndStateAndCellPhoneFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :city, :string
    remove_column :users, :state, :string
    remove_column :users, :cell_phone, :string
  end
end
