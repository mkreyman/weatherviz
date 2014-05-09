class AddVerifiedEmailAndTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verified_email, :boolean, default: false
    add_column :users, :token, :string, default: ''
  end
end
