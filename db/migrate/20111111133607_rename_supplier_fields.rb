class RenameSupplierFields < ActiveRecord::Migration
  def up
    rename_column :suppliers, :supplier_name, :name
    rename_column :suppliers, :supplier_email, :email
    rename_column :suppliers, :supplier_address, :address
    rename_column :suppliers, :supplier_description, :description
    rename_column :suppliers, :supplier_number, :contact_number
  end

  def down
    rename_column :suppliers, :name, :supplier_name
    rename_column :suppliers, :email, :supplier_email
    rename_column :suppliers, :address, :supplier_address
    rename_column :suppliers, :description, :supplier_description
    rename_column :suppliers, :contact_number, :supplier_number
  end
end
