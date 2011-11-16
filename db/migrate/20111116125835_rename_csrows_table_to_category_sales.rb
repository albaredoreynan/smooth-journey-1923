class RenameCsrowsTableToCategorySales < ActiveRecord::Migration
  def up
    rename_table :csrows, :category_sales
  end

  def down
    rename_table :category_sales, :csrows
  end
end
