class RenameUnitFieldsOnConversions < ActiveRecord::Migration
  def change
    rename_column :conversions, :bigger_unit, :bigger_unit_id
    rename_column :conversions, :smaller_unit, :smaller_unit_id
  end
end
