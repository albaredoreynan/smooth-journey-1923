class RenameCompanyNumberToContactNumber < ActiveRecord::Migration
  def up
    rename_column :companies, :company_number, :contact_number
  end

  def down
    rename_column :companies, :contact_number, :company_number
  end
end
