class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :field
      t.string :operation
      t.string :value
      t.boolean :triggered, default: false
      t.references :alert, index: true

      t.timestamps
    end
  end
end
