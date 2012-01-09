class AddIndexBranchIdOnItems < ActiveRecord::Migration
  def up
    add_index :items, :branch_id
  end

  def down
    remove_index :items, :branch_id
  end
end
