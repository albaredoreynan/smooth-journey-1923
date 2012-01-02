class AddedFieldParticularsInPurchaseItemsTable < ActiveRecord::Migration
  def change
    add_column :purchase_items, :particulars, :string
  end
end
