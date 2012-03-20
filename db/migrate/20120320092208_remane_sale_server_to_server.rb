class RemaneSaleServerToServer < ActiveRecord::Migration
  def up
    rename_table :sale_servers, :servers
  end

  def down
    rename_table :servers, :sale_servers
  end
end
