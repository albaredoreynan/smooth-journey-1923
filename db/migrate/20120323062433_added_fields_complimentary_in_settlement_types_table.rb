class AddedFieldsComplimentaryInSettlementTypesTable < ActiveRecord::Migration
  def change
    add_column :settlement_types, :complimentary, :boolean
  end
end
