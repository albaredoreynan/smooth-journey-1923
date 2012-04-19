class AddedFieldsInSalesTable < ActiveRecord::Migration
  def change
    add_column :sales, :delivery_transaction_count, :decimal
    add_column :sales, :credit_card_transaction_count, :decimal
    add_column :sales, :first_time_guest, :integer
    add_column :sales, :repeat_guest, :integer
  end
end
