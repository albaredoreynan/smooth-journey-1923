class RenamePurchaseitemsTableToPurchaseItems < ActiveRecord::Migration
  def up
    rename_table :purchaseitems, :purchase_items
  end

  def down
    rename_table :purchase_items, :purchaseitems
  end
end
