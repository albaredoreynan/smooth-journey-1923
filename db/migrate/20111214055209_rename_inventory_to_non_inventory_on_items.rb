class RenameInventoryToNonInventoryOnItems < ActiveRecord::Migration
  def change
    rename_column :items, :inventory, :non_inventory
  end
end
