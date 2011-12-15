class AddBranchIdToSettlementType < ActiveRecord::Migration
  def change
    add_column :settlement_types, :branch_id, :integer
  end
end
