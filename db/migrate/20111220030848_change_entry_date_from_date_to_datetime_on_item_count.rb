class ChangeEntryDateFromDateToDatetimeOnItemCount < ActiveRecord::Migration
  def up
    change_column :item_counts, :entry_date, :datetime
  end

  def down
    change_column :item_counts, :entry_date, :date
  end
end
