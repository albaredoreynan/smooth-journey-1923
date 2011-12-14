class AddContactPersonAndCompanyIdToSuppliers < ActiveRecord::Migration
  def change
     add_column :suppliers, :contact_person, :string
     add_column :suppliers, :company_id, :integer 
  end
end
