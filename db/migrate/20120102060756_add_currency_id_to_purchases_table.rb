class AddCurrencyIdToPurchasesTable < ActiveRecord::Migration
  def change
    add_column :purchases, :currency_id, :integer
  end
end
