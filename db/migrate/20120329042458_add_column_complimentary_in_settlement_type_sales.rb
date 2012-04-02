class AddColumnComplimentaryInSettlementTypeSales < ActiveRecord::Migration
  def change
    add_column :settlement_type_sales, :complimentary, :boolean
  end
end
