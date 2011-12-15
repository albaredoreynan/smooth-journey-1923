class AddEntryDateInItemCountsTable < ActiveRecord::Migration
  def change
    add_column :item_counts, :entry_date, :date
  end
end
