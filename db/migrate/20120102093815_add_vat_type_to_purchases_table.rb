class AddVatTypeToPurchasesTable < ActiveRecord::Migration
  def change
    add_column :purchases, :vat_type, :text
  end
end
