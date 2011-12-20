class RenameConversionNumberToConversionFactorOnConversions < ActiveRecord::Migration
  def change
    rename_column :conversions, :conversion_number, :conversion_factor
  end
end
