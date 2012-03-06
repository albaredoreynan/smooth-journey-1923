class AddBranchIdOnItemCounts < ActiveRecord::Migration
  def up
    add_column :item_counts, :branch_id, :integer
  end

  def down
    remove_column :item_counts, :branch_id
  end
end
