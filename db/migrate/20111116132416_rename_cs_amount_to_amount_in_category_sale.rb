class RenameCsAmountToAmountInCategorySale < ActiveRecord::Migration
  def up
    rename_column :category_sales, :cs_amount, :amount
  end

  def down
    rename_column :category_sales, :amount, :cs_amount
  end
end
