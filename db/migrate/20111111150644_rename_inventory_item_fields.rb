class RenameInventoryItemFields < ActiveRecord::Migration
  def up
    rename_column :inventoryitems, :item_name, :name
  end

  def down
    rename_column :inventoryitems, :name, :item_name
  end
end
