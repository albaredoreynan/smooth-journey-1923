class AddedNewFieldsToTableSuppliers < ActiveRecord::Migration
  def change
    add_column :suppliers, :tin, :string
    add_column :suppliers, :mobile_number, :string
    add_column :suppliers, :contact_title, :string 
  end
end
