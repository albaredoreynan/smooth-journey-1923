class AddColumnDeletedAtInAmountMultipliers < ActiveRecord::Migration
  def change
    add_column :amount_multipliers, :deleted_at, :date
  end
end
