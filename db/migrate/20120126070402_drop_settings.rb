class DropSettings < ActiveRecord::Migration
  def up
    drop_table :settings
  end

  def down
    create_table :settings do |t|
      t.belongs_to :company
      t.boolean :enable_lock_module
      t.integer :lock_module_in
    end
  end
end
