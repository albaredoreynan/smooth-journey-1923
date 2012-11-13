class AddColumnEmployeeIdInTableLaborHours < ActiveRecord::Migration
  def change
    add_column :labor_hours, :employee_id, :integer
  end
end
