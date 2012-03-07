class RemoveColumnsInSales < ActiveRecord::Migration
  def up
    remove_column :sales, :employee_id
    remove_column :sales, :void
    remove_column :sales, :date
    remove_column :sales, :revenue_ss
    remove_column :sales, :dinein_cc
    remove_column :sales, :dinein_tc
    remove_column :sales, :dinein_ppa
    remove_column :sales, :dinein_pta
    remove_column :sales, :delivery_tc
    remove_column :sales, :delivery_pta
    remove_column :sales, :takeout_tc
    remove_column :sales, :takeout_pta
    remove_column :sales, :total_amount_cs
    remove_column :sales, :total_revenue_cs
    remove_column :sales, :save_as_draft
  end

  def down
    add_column :sales, :employee_id, :integer
    add_column :sales, :void, :float
    add_column :sales, :date, :date
    add_column :sales, :revenue_ss, :float
    add_column :sales, :dinein_cc, :float
    add_column :sales, :dinein_tc, :float
    add_column :sales, :dinein_ppa, :float
    add_column :sales, :dinein_pta, :float
    add_column :sales, :delivery_tc, :float
    add_column :sales, :delivery_pta, :float
    add_column :sales, :takeout_tc, :float
    add_column :sales, :takeout_pta, :float
    add_column :sales, :total_amount_cs, :float
    add_column :sales, :total_revenue_cs, :float
    add_column :sales, :save_as_draft, :boolean
  end
end
