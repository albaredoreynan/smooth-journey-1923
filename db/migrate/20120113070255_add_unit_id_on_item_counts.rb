class AddUnitIdOnItemCounts < ActiveRecord::Migration
  def up
    add_column :item_counts, :unit_id, :integer
    add_index :item_counts, :unit_id
  end

  def down
    remove_index :item_counts, :unit_id
    remove_column :item_counts, :unit_id
  end
end
