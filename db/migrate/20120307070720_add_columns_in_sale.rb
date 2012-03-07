class AddColumnsInSale < ActiveRecord::Migration
  def change
    add_column :sales, :sale_date, :date
    add_column :sales, :gc_redeemed, :decimal
    add_column :sales, :cash_in_drawer, :decimal
    add_column :sales, :gc_sales, :decimal
    add_column :sales, :other_income, :decimal
    add_column :sales, :created_by_id, :integer
  end
end
