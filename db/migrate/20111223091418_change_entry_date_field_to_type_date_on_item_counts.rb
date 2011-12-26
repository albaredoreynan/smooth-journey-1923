class ChangeEntryDateFieldToTypeDateOnItemCounts < ActiveRecord::Migration
  def up
    change_column :item_counts, :entry_date, :date
  end

  def down
    change_column :item_counts, :entry_date, :timestamp
  end
end
