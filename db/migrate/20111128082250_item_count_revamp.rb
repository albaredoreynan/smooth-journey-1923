class ItemCountRevamp < ActiveRecord::Migration
  def up
    remove_column :item_counts, :endcount_id
    remove_column :item_counts, :begin_count
    rename_column :item_counts, :end_count, :count
  end

  def down
    add_column :item_counts, :endcount_id, :integer
    add_column :item_counts, :begin_count
    rename_column :item_counts, :count, :end_count
  end
end
