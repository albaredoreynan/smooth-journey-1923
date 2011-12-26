class RemoveDeltaColumnOnItemCounts < ActiveRecord::Migration
  def up
    remove_column :item_counts, :delta
  end

  def down
    add_column :item_counts, :delta, :integer
  end
end
