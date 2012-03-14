class SetColumnDefaultsInSales < ActiveRecord::Migration
  def up
    change_column_default :sales, :vat, 0.00
    change_column_default :sales, :customer_count, 0.00
    change_column_default :sales, :transaction_count, 0.00
    change_column_default :sales, :delivery_sales, 0.00
    change_column_default :sales, :service_charge, 0.00
    change_column_default :sales, :gc_redeemed, 0.00
    change_column_default :sales, :cash_in_drawer, 0.00
    change_column_default :sales, :gc_sales, 0.00
    change_column_default :sales, :other_income, 0.00
  end

  def down
    change_column_default :sales, :vat, nil
    change_column_default :sales, :customer_count, nil
    change_column_default :sales, :transaction_count, nil
    change_column_default :sales, :delivery_sales, nil
    change_column_default :sales, :service_charge, nil
    change_column_default :sales, :gc_redeemed, nil
    change_column_default :sales, :cash_in_drawer, nil
    change_column_default :sales, :gc_sales, nil
    change_column_default :sales, :other_income, nil
  end
end
