class AddedBranchIdInSaleServersTable < ActiveRecord::Migration
  def up
    add_column :sale_servers, :branch_id, :integer
  end

  def down
    remove_column :sale_servers, :branch_id
  end
end
