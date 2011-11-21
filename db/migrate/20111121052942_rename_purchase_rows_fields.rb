class RenamePurchaseRowsFields < ActiveRecord::Migration
  def up
    rename_column :purchaserows, :inventoryitem_id, :item_id
    rename_column :purchaserows, :purchase_unit, :unit_id
    rename_column :purchaserows, :purchase_unitCost, :unit_cost
    rename_column :purchaserows, :purchase_quantity, :quantity
    rename_column :purchaserows, :purchase_amount, :amount
    add_index :purchaserows, :item_id
    add_index :purchaserows, :unit_id
    add_index :purchaserows, :purchase_id
  end

  def down
    rename_column :purchaserows, :item_id, :inventoryitem_id
    rename_column :purchaserows, :unit_id, :purchase_unit
    rename_column :purchaserows, :unit_cost, :purchase_unitCost
    rename_column :purchaserows, :quantity, :purchase_quantity
    rename_column :purchaserows, :amount, :purchase_amount
  end
end
