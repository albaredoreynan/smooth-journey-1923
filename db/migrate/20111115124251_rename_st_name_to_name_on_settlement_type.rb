class RenameStNameToNameOnSettlementType < ActiveRecord::Migration
  def up
    rename_column :settlement_types, :st_name, :name
  end

  def down
    rename_column :settlement_types, :name, :st_name
  end
end
