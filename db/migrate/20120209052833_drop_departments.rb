class DropDepartments < ActiveRecord::Migration
  def change
    drop_table :departments
  end
end
