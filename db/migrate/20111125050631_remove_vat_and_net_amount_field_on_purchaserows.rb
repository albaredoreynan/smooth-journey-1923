class RemoveVatAndNetAmountFieldOnPurchaserows < ActiveRecord::Migration
  def up
    remove_column :purchaserows, :vat_amount
    remove_column :purchaserows, :net_amount
  end

  def down
    add_column :purchaserows, :vat_amount, :decimal
    add_column :purchaserows, :net_amount, :decimal
  end
end
