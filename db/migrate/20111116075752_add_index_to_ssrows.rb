class AddIndexToSsrows < ActiveRecord::Migration
  def up
    add_index :ssrows, :sale_id
  end
  def down
    remove_index :ssrows, :sale_id
  end
end
