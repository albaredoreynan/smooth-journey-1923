class AddColumnHdmfInTableEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :hdmf, :string
  end
end
