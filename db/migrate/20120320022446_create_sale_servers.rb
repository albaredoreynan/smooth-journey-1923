class CreateSaleServers < ActiveRecord::Migration
  def change
    create_table :sale_servers do |t|
      t.string :name
      t.timestamp :date

      t.timestamps
    end
  end
end
