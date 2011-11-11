class RenameBranchFields < ActiveRecord::Migration
  def up
    rename_column :branches, :branch_location, :location
    rename_column :branches, :branch_contactNumber, :contact_number
    rename_column :branches, :branch_address, :address
  end

  def down
    rename_column :branches, :location, :branch_location
    rename_column :branches, :contact_number, :branch_contactNumber
    rename_column :branches, :address, :branch_address
  end
end
