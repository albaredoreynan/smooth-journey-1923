class RenameCompanyFields < ActiveRecord::Migration
  def up
    rename_column :companies, :company_name, :name
    rename_column :companies, :company_address, :address
  end

  def down
    rename_column :companies, :name, :company_name
    rename_column :companies, :address, :company_address
  end
end
