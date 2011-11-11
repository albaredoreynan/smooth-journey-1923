class RenameConversionField < ActiveRecord::Migration
  def up
    rename_column :conversions, :conversionNumber, :conversion_number
  end

  def down
    rename_column :conversions, :conversion_number, :conversionNumber
  end
end
