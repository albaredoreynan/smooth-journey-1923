class RenameSsrowsTableToSettlementTypeSales < ActiveRecord::Migration
  def up
    rename_table :ssrows, :settlement_type_sales
  end

  def down
    rename_table :settlement_type_sales, :ssrows
  end
end
