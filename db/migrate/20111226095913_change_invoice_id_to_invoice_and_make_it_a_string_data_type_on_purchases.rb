class ChangeInvoiceIdToInvoiceAndMakeItAStringDataTypeOnPurchases < ActiveRecord::Migration
  def up
    rename_column :purchases, :invoice_id, :invoice_number
    change_column :purchases, :invoice_number, :string
  end

  def down
    execute 'ALTER TABLE purchases ALTER COLUMN invoice_number TYPE integer USING invoice_number::INTEGER'
    rename_column :purchases, :invoice_number, :invoice_id
  end
end
