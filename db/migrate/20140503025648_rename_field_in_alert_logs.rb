class RenameFieldInAlertLogs < ActiveRecord::Migration
  def change
    rename_column :alert_logs, :alerts_id, :alert_id
  end
end
