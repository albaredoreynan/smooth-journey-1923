class RemoveColumnsInSales2 < ActiveRecord::Migration
  def up
    remove_column :sales, :gross_total_ss
    remove_column :sales, :net_total_ss
  end

  def down
    add_column :sales, :gross_total_ss, :float
    add_column :sales, :net_total_ss, :float
  end
end
