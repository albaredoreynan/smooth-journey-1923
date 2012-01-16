class AddSettings < ActiveRecord::Migration
  def up
    create_table :settings do |t|
      t.references :company
      t.boolean :enable_lock_module
      t.integer :lock_module_in
    end
  end

  def down
    drop_table :settings
  end
end
