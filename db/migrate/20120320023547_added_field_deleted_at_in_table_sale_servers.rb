class AddedFieldDeletedAtInTableSaleServers < ActiveRecord::Migration
  def change
    add_column :sale_servers, :deleted_at, :datetime
    add_column :sale_servers, :branch_id, :integer
  end
end
