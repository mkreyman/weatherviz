class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.string :alert_name
      t.boolean :by_email, default: false
      t.boolean :by_sms, default: false
      t.string :email
      t.string :sms
      t.boolean :email_verified, default: false
      t.boolean :phone_verified, default: false
      t.boolean :active
      t.references :user, index: true

      t.timestamps
    end
  end
end
