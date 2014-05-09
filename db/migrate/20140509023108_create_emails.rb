class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :address
      t.string :token, default: ''
      t.boolean :verified, default: false
      t.references :user, index: true

      t.timestamps
    end
  end
end
