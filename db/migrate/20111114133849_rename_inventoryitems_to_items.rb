class RenameInventoryitemsToItems < ActiveRecord::Migration
  def up
    rename_table :inventoryitems, :items
  end

  def down
    rename_table :items, :inventoryitems
  end
end
