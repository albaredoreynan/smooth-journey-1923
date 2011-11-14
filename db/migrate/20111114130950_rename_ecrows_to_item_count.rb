class RenameEcrowsToItemCount < ActiveRecord::Migration
  def up
    rename_table :ecrows, :item_counts
  end

  def down
    rename_table :item_counts, :ecrows
  end
end
