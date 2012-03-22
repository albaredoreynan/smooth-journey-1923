class CreateSaleServersAgain < ActiveRecord::Migration
  def up
    create_table :sale_servers do |t|
      t.integer :sale_id
      t.integer :server_id
      t.decimal :amount, :default => 0.00

      t.datetime :deleted_at
      t.timestamps
    end
  end

  def down
    drop_table :sale_servers
  end
end
