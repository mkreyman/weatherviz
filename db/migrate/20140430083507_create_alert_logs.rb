class CreateAlertLogs < ActiveRecord::Migration
  def change
    create_table :alert_logs do |t|
      t.datetime :sent_at
      t.text :alert_message
      t.text :alert_message_types
      t.references :alerts, index: true

      t.timestamps
    end
  end
end
