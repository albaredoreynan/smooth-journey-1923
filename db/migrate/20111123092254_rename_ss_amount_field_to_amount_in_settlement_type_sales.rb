class RenameSsAmountFieldToAmountInSettlementTypeSales < ActiveRecord::Migration
  def up
    rename_column :settlement_type_sales, :ss_amount, :amount
  end

  def down
    rename_column :settlement_type_sales, :amount, :ss_amount
  end
end
