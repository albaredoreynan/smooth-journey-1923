class RenamePurchaseItemsFields < ActiveRecord::Migration
  def up
    rename_column :purchase_items, :purchase_unit, :unit
    rename_column :purchase_items, :purchase_unitCost, :unit_cost
    rename_column :purchase_items, :purchase_quantity, :quantity
    rename_column :purchase_items, :purchase_amount, :amount
  end

  def down
    rename_column :purchase_items, :unit, :purchase_unit
    rename_column :purchase_items, :unit_cost, :purchase_unitCost
    rename_column :purchase_items, :quantity, :purchase_quantity
    rename_column :purchase_items, :amount, :purchase_amount
  end
end
