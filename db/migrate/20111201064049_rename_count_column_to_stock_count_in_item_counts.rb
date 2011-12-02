class RenameCountColumnToStockCountInItemCounts < ActiveRecord::Migration
  def up
    rename_column :item_counts, :count, :stock_count
  end

  def down
    rename_column :item_counts, :stock_count, :count
  end
end
