class RemoveAgeToEmployees < ActiveRecord::Migration
  def up
    remove_column :employees, :age
  end

  def down
    add_column :employees, :age, :integer
  end
end
