class RenamePurchaserowsToPurchaseItems < ActiveRecord::Migration
  def up
    drop_table :purchase_items
    rename_table :purchaserows, :purchase_items
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
