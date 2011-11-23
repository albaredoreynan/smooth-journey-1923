class RenameBeginningToBegin < ActiveRecord::Migration
  def up
    rename_column :endcounts, :beginning_date, :begin_date
    rename_column :item_counts, :beginning_count, :begin_count
  end

  def down
    rename_column :endcounts, :begin_date, :beginning_date
    rename_column :item_counts, :begin_count, :beginning_count
  end
end
