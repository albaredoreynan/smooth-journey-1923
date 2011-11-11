class RenameColumnsInEmployees < ActiveRecord::Migration
  def up
    rename_column :employees, :employee_firstName, :first_name
    rename_column :employees, :employee_lastName, :last_name
    rename_column :employees, :employee_dateEmployed, :date_employed
    rename_column :employees, :employee_birthday, :birthdate
    rename_column :employees, :employee_age, :age
    rename_column :employees, :employee_contactNumber, :contact_number
    rename_column :employees, :employee_sss, :sss
    rename_column :employees, :employee_tin, :tin
    rename_column :employees, :employee_address, :address
  end

  def down
    rename_column :employees, :first_name, :employee_firstName
    rename_column :employees, :last_name, :employee_lastName
    rename_column :employees, :date_employed, :employee_dateEmployed
    rename_column :employees, :birthdate, :employee_birthday
    rename_column :employees, :age, :employee_age
    rename_column :employees, :contact_number, :employee_contactNumber
    rename_column :employees, :sss, :employee_sss
    rename_column :employees, :tin, :employee_tin
    rename_column :employees, :address, :employee_address
  end
end
