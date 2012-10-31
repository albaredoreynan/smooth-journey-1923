class AddColumnDeletedAtOnTableLaborHours < ActiveRecord::Migration
  def change
    add_column :labor_hours, :deleted_at, :date
  end
end
