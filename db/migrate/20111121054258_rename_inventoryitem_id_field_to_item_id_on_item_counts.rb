class RenameInventoryitemIdFieldToItemIdOnItemCounts < ActiveRecord::Migration
  def up
    rename_column :item_counts, :inventoryitem_id, :item_id
  end

  def down
    rename_column :item_counts, :item_id, :inventoryitem_id
  end
end
