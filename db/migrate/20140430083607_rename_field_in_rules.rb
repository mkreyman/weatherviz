class RenameFieldInRules < ActiveRecord::Migration
  def change
    rename_column :rules, :operation, :operator
  end
end
