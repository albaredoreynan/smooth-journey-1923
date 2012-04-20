class RemoveBranchIdInSettlementTypeTable < ActiveRecord::Migration
  def up
    remove_column :settlement_types, :branch_id
  end

  def down
    add_column :settlement_types, :branch_id, :integer
  end
end
